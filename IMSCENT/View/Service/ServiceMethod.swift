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

    @Published var isAnimating = false
    @Published var isSelect: [String?] = [nil, nil, nil]
    @Published var isSelectedImageAnimating: Bool = false


    @StateObject var PP = PhotoPickerViewModel()

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
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 16)
    }

    @ViewBuilder
    func TitleImage(image: String, width: Double, height: Double) -> some View {
        Image(image)
            .resizable()
            .scaledToFit()
            .frame(width: width, height: height)
    }
}



struct CAnimating: ViewModifier {
    @State var isSelectedImageAnimating: Bool


    func body(content: Content) -> some View {
        content
            .offset(y: isSelectedImageAnimating ? 0 : 20)
            .opacity(isSelectedImageAnimating ? 1 : 0)
            .animation(.easeInOut.delay(0.5), value: isSelectedImageAnimating)
            .onAppear {
                isSelectedImageAnimating.toggle()
        }
            .onDisappear() {
            isSelectedImageAnimating.toggle()
        }
    }
}

struct CAnimatingDelay: ViewModifier {

    @State var isSelectedImageAnimating: Bool
    let delay: Double


    func body(content: Content) -> some View {
        content
            .offset(y: isSelectedImageAnimating ? 0 : 20)
            .opacity(isSelectedImageAnimating ? 1 : 0)
            .animation(.easeInOut.delay(delay), value: isSelectedImageAnimating)
            .onAppear {
            isSelectedImageAnimating.toggle()
        }
            .onDisappear() {
            isSelectedImageAnimating.toggle()
        }
    }
}
