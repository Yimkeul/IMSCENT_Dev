//
//  Perfume.swift
//  IMSCENT
//
//  Created by yimkeul on 2023/09/28.
//

import Foundation
import SwiftUI

struct Perfume: Identifiable, Equatable {
    var id = UUID().uuidString
    var perfumeImage: String
}


var perfumes: [Perfume] = [
    Perfume(perfumeImage: "P4"),
    Perfume(perfumeImage: "P5"),
    Perfume(perfumeImage: "P6"),
    Perfume(perfumeImage: "P4"),
    Perfume(perfumeImage: "P5"),
    Perfume(perfumeImage: "P6")
]

