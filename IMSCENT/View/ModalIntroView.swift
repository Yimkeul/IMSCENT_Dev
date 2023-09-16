//
//  ModalIntroView.swift
//  IMSCENT
//
//  Created by yimkeul on 2023/09/16.
//

import SwiftUI

struct ModalIntroView: View {
    @Binding var isFirst:Bool
    var body: some View {
        ZStack{
            Color.indigo.ignoresSafeArea()
        
        TabView {
            IntroView1()
            IntroView2()
            IntroViewTest(isFirst: $isFirst)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
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


struct IntroViewTest: View{
    @Binding var isFirst:Bool
    var body: some View {
        VStack{
            Text("설명글 3번째")
            Button {
                isFirst.toggle()
            } label: {
                Text("모달 닫기")
            }

        }
    }
}
struct ModalIntroView_Previews: PreviewProvider {
    static var previews: some View {
        ModalIntroView(isFirst: .constant(true))
    }
}
