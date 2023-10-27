//
//  ServerCheckViewModel.swift
//  IMSCENT
//
//  Created by yimkeul on 2023/10/26.
//

import Foundation
import Moya
import Combine

class ServerCheckViewModel: ObservableObject {
    var cancellables = Set<AnyCancellable>()
    static let shared = ServerCheckViewModel()
    @Published var getCheck: ServerCheckModel? // 분석 결과

    private let provider = MoyaProvider<APIService>()
    

    func requestServer(completion: @escaping (Result<ServerCheckModel, Error>) -> Void) {
        provider.request(.getCheck) { result in
            switch result {
            case .success(let response):
                do {
                    let decodedResponse = try JSONDecoder().decode(ServerCheckModel.self, from: response.data)
                    DispatchQueue.main.async {
                        self.getCheck = decodedResponse
                    }
                    print("result : \(decodedResponse)")
                    completion(.success(decodedResponse))
                } catch let error {
                    print("Decoding error ServerCheck: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            case .failure(let error):
                print("Error ServerCheck: \(error.localizedDescription)")
                let errorResponse = ServerCheckModel(success: false)
                self.getCheck = errorResponse
                print("result failure: \(errorResponse)")
                completion(.failure(error))
            }
        }
    }

    func startBackgroundCheck() -> AnyPublisher<Bool, Never> {
          return Future<Bool, Never> { promise in
              self.requestServer { result in
                  switch result {
                  case .success:
                      print("서버 연결됨 \(String(describing: self.getCheck))")
                      promise(.success(true))
                  case .failure:
                      DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
                          self.startBackgroundCheck()
                              .sink(receiveValue: { value in
                                  promise(.success(value))
                              })
                              .store(in: &self.cancellables)
                      }
                      print("서버 죽음 \(String(describing: self.getCheck))")
                  }
              }
          }
          .eraseToAnyPublisher()
      }
}

