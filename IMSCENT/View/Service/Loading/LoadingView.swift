//
//  LoadingView.swift
//  IMSCENT
//
//  Created by yimkeul on 2023/09/26.
//

import SwiftUI
import NukeUI

struct LoadingView: View {

    @StateObject var SM = ServiceMethod()
    @StateObject var PM = ProgressBarMethod()
    @StateObject var PP = PhotoPickerViewModel()
    @StateObject var RV = RecommandViewModel()

    @Environment(\.presentationMode) var presentationMode

    @State var isLoading: Bool = true

    var body: some View {
        VStack {
            if isLoading {
                LoadingAnimation()
            } else {
                VStack {
                    ResultView(SM: SM, PM: PM, PP: PP, RV: RV)
                }
            }
        }
            .onAppear {
            SM.isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                isLoading = false
                Recommand()
            })
        }
    }

    private func Recommand() {
        if RV.requestRecoomand(sex: SM.isSelect[0]!, age: SM.isSelect[1]!, style: PP.detectResult) {
            print("success recomand")
        } else {
            print("fail recomand")
        }
    }

}

#Preview {
    LoadingView()
}
