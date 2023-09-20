//
//  ProgressData.swift
//  IMSCENT
//
//  Created by yimkeul on 2023/09/17.
//

import Foundation
import SwiftUI

class ProgressAmount: ObservableObject {
    @Published var progressAmont: Double = -1
}
// 상단 상태바
struct RoundedRectProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        GeometryReader {
            geo in
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.cWG)
                .frame(width: geo.size.width, height: 14)

            RoundedRectangle(cornerRadius: 14)
                .fill(.black)
                .frame(width: CGFloat(configuration.fractionCompleted ?? 0) * geo.size.width, height: 14)

        }.frame(height: 14)
    }
}


