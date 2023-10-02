//
//  Service.swift
//  IMSCENT
//
//  Created by yimkeul on 2023/09/26.
//

import Foundation
import Moya
import Combine

enum TeachableService {
    case getAll(imageData: Data)
    case getRecommand(sex: String, age: String, style: String)
}

extension TeachableService: TargetType {
    var baseURL: URL {
        return URL(string: "https://port-0-teachablemachineapi-2u73n2llm7ax6bh.sel5.cloudtype.app")!
    }

    var path: String {
        switch self {
        case .getAll:
            return "/uploadImage"
        case .getRecommand:
            return "/recommand"
        }

    }

    var method: Moya.Method {
        switch self {
        case .getAll:
            return .post
        case .getRecommand:
            return .get
        }

    }

    var task: Moya.Task {
        switch self {
        case .getAll(let imageData):
            return .uploadMultipart([MultipartFormData(provider: .data(imageData), name: "image", fileName: "image.jpeg", mimeType: "image/jpeg")])
        case .getRecommand(let sex, let age, let style):
            let parameters: [String: Any] = [
                "sex": sex,
                "age": age,
                "style": style
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }

    }

    var headers: [String: String]? {
        switch self {
        case .getAll:
            return ["Content-type": "multipart/form-data"]
        case .getRecommand:
            return ["Content-Type": "application/json"]
        }

    }
}


