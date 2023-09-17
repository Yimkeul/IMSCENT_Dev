//
//  ModalIntroView.swift
//  IMSCENT
//
//  Created by yimkeul on 2023/09/16.
//

import SwiftUI

struct ModalIntroView: View {
    @Binding var isFirst: Bool
    var body: some View {
        ZStack {
            Color.cGray.ignoresSafeArea()
            TabView {
                IntroView1()
                IntroView2()
                IntroViewTest(isFirst: $isFirst)
            }
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        }
    }
}

@ViewBuilder
private func IntroView1() -> some View {
    VStack {
        Text("설명글 1번째 화면")
    }
}

@ViewBuilder
private func IntroView2() -> some View {
    VStack {
        Text("설명글 2번째 화면")
    }
}


struct IntroViewTest: View {
    @Binding var isFirst: Bool
    var body: some View {
        GeometryReader {
            geo in
            VStack {
                Spacer()
                Text("설명글 3번째")
                Spacer()
                Button {
                    isFirst.toggle()
                } label: {
                    Text("모달 닫기")
                }.padding(.bottom, geo.size.height*0.1)
//                Text("wid:\(geo.size.width) , hei : \(geo.size.height)")
//                Spacer().frame(height: geo.size.height * 0.15)
            }.frame(width: geo.size.width, height: geo.size.height)
        }
    }
}
struct ModalIntroView_Previews: PreviewProvider {
    static var previews: some View {
        ModalIntroView(isFirst: .constant(true))
    }
}
