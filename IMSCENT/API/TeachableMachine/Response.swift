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

struct RecommandModel: Codable {
    let resultFilter: resultFilterValue
    
}

struct resultFilterValue: Codable, Hashable {
    let idx: Int
    let title: String
    let explain : String
    let sex: String
    let age: Int
    let style: String
    let imglink: String
    let link: String
}
