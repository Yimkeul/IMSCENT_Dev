//
//  SaveViewModel.swift
//  IMSCENT
//
//  Created by yimkeul on 2023/10/09.
//

import Foundation
import SwiftUI

class SaveViewModel: ObservableObject {
    @AppStorage("save") var SavePerfume: Data = Data()
    @Published var SaveData:[resultFilterValue] = []
    
    func decodeSave() -> [resultFilterValue] {
          if let decodedArray = try? JSONDecoder().decode([resultFilterValue].self, from: SavePerfume) {
              return decodedArray
          } else {
              return []
          }
      }
      
      // 배열에 값을 추가하는 메서드
      func encodeSave(value: resultFilterValue) {
          var currentArray = decodeSave()
          currentArray.append(value)
          if let encodedArray = try? JSONEncoder().encode(currentArray) {
              SavePerfume = encodedArray
          }
      }
    
    func popLastSave() {
        var currentArray = decodeSave()
        currentArray.removeLast()
        if let encodedArray = try? JSONEncoder().encode(currentArray) {
            SavePerfume = encodedArray
        }
    }
    
    func popIDSave(idx: Int) {
        var currentArray = decodeSave()
        currentArray = currentArray.filter{ $0.idx != idx }
        if let encodedArray = try? JSONEncoder().encode(currentArray) {
            SavePerfume = encodedArray
        }
        
    }
    
}
