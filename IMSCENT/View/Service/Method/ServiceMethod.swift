//
//  ServiceMethod.swift
//  IMSCENT
//
//  Created by yimkeul on 2023/09/19.
//

import Foundation
import SwiftUI
//import PhotosUI

class ServiceMethod: ObservableObject {

    @Published var isSelect: [String?] = [nil, nil, nil]
    @Published var isLoading: Bool = false
    

    func clearSelect(_ index: Int) {
        isSelect[index] = nil
    }
    func clearAll() {
        isSelect = [nil, nil, nil]
    }

    @ViewBuilder
    func previous() -> some View {
        HStack(spacing: 4) {
            Image(systemName: "chevron.left")
                .font(.system(size: 20, weight: .bold))

            Text("이전")
                .font(.system(size: 20, weight: .heavy))
        }.foregroundColor(.black)
    }

    @ViewBuilder
    func next(isSelect: String?) -> some View {
        HStack(spacing: 4) {
            Text("다음")
                .font(.system(size: 20, weight: .heavy))

            Image(systemName: "chevron.right")
                .font(.system(size: 20, weight: .bold))

        }.foregroundColor(isSelect != nil ? .black : nil)
    }

    @ViewBuilder
    func Title(title: String) -> some View {
            Text("\(title)")
                .font(.system(size: 20, weight: .semibold))
    }

    @ViewBuilder
    func TitleImage(image: String, height: Double) -> some View {
        Image(image)
            .resizable()
            .scaledToFit()
            .frame(height: height)
    }
}



struct CAnimating: ViewModifier {
    var isAnimating: Bool

    func body(content: Content) -> some View {
        content
            .offset(y: isAnimating ? 0 : 10)
            .opacity(isAnimating ? 1 : 0)
            .animation(.easeInOut(duration: 0.5).delay(0.5), value: isAnimating)
    }
}

struct CAnimatingDelay: ViewModifier {

    @State var isAnimating: Bool
    let delay: Double
    let duration: Double
    
    func body(content: Content) -> some View {
        content
            .offset(y: isAnimating ? 0 : 10)
            .opacity(isAnimating ? 1 : 0)
            .animation(.easeInOut(duration: duration).delay(delay), value: isAnimating)
            .onAppear {
                isAnimating = true
        }
            .onDisappear() {
                isAnimating = false
        }
    }
}
