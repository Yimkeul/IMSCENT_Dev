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
                    print("Decoding error Teach: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            case .failure(let error):
                print("Error Teach: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
    
    func startBackgroundCheck() {
           // 백그라운드에서 API 체크를 시작
           self.requestServer { result in
               switch result {
               case .success:
                   print("서버 연결됨")
               case .failure:
                   DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
                       self.startBackgroundCheck()
                   }
                   // 에러 처리
                   print("서버 죽음")
               }
           }
       }
}

