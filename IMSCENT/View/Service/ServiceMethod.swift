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
    @Published var goHome: Bool = false

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
                .font(.system(.title3, weight: .bold))
            Text("이전")
                .font(.system(.title3, weight: .heavy))
        }.foregroundColor(.black)
    }
    
    @ViewBuilder
    func next(isSelect: String?) -> some View {
        HStack(spacing: 4) {
            Text("다음")
                .font(.system(.title3, weight: .heavy))

            Image(systemName: "chevron.right")
                .font(.system(.title3, weight: .bold))
        }.foregroundColor(isSelect != nil ? .black : nil)
    }

    @ViewBuilder
    func Title(title: String) -> some View {
        Text("\(title)")
            .font(.system(.headline, weight: .semibold))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 16)
    }
}
