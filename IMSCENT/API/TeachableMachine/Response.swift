//
//  Response.swift
//  IMSCENT
//
//  Created by yimkeul on 2023/09/26.
//

import Foundation

struct TeachableModel: Codable {
    let classProbabilities: [[Double]]
    let topClassIndex: Int
    let resultMessage: String
}

struct ImageURLModel: Codable {
    let imageURL: String
}
