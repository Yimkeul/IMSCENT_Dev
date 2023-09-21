//
//  ProgressData.swift
//  IMSCENT
//
//  Created by yimkeul on 2023/09/17.
//

import Foundation
import SwiftUI

class ProgressBarMethod: ObservableObject {
    @Published var progressAmont: Double = 0
    // MARK: 프로그래스바 애니메이션
    @Published var isAnimating = false
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


