//
//  RecommandViewModel.swift
//  IMSCENT
//
//  Created by yimkeul on 2023/10/02.
//

import Foundation
import Moya
import Combine

class RecommandViewModel: ObservableObject {
    @Published var getRecommand: RecommandModel? // 분석 결과

    private let provider = MoyaProvider<APIService>()

    func requestRecoomand(sex: String, age: String, style: String) -> Bool {
        print("test: ", sex)
        if sex == "male" {
            self.getRecommand = RecommandModel.init(resultFilter: manAll.randomElement()!)
            return true
        } else {
            self.getRecommand = RecommandModel.init(resultFilter: womanAll.randomElement()!)
            return true
        }
    }

    func requestRecoomand(sex: String, age: String, style: String, completion: @escaping (Result<RecommandModel, Error>) -> Void) {
        provider.request(.getRecommand(sex: sex, age: age, style: style)) { result in
            switch result {
            case .success(let response):
                do {
                    let decodedResponse = try JSONDecoder().decode(RecommandModel.self, from: response.data)
                    DispatchQueue.main.async {
                        self.getRecommand = decodedResponse
                    }
                    print("result : \(decodedResponse)")
                    completion(.success(decodedResponse))
                } catch let error {
                    print("Decoding error Recommand: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            case .failure(let error):
                print("Error Recommand: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }

}

