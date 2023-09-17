//
//  ProgressData.swift
//  IMSCENT
//
//  Created by yimkeul on 2023/09/17.
//

import Foundation
import SwiftUI

class ProgressAmount : ObservableObject {
    @Published var progressAmont: Double = 0.0
}

struct RoundedRectProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 14)
                .frame(width: 250, height: 28)
                .foregroundColor(.blue)
                .overlay(Color.black.opacity(0.5)).cornerRadius(14)
            
            RoundedRectangle(cornerRadius: 14)
                .frame(width: CGFloat(configuration.fractionCompleted ?? 0) * 250, height: 28)
                .foregroundColor(.yellow)
        }
        .padding()
    }
}
 
