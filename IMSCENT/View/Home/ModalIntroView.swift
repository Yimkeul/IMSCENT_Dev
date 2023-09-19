//
//  ModalIntroView.swift
//  IMSCENT
//
//  Created by yimkeul on 2023/09/16.
//

import SwiftUI

struct CustomPageControl: View {
    let numberOfPages: Int
    @Binding var currentPage: Int
    @Binding var isAnimation: Bool
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<numberOfPages, id: \.self) { page in
                Image(systemName: "minus")
                    .resizable()
                    .frame(width: page == currentPage ? 40 : 20, height: page == currentPage ? 8 : 6)
                    .foregroundColor(page == currentPage ? .black : Color.cWG)
                    .animation(.easeInOut, value: isAnimation)
            }
        }
    }
}

struct ModalIntroView: View {
    @Binding var isFirst: Bool
    @State private var isAnimation: Bool = false
    @State private var currentPage = 0
    let numberOfPages = 3

    var body: some View {
        ZStack {
            VStack {
                TabView(selection: $currentPage) {

                    IntroView1()
                        .tag(0)
                        .tabItem {
                        Image(systemName: "minus")
                    }

                    IntroView2()
                        .tag(1)
                        .tabItem {
                        Image(systemName: "minus")
                    }

                    IntroViewTest(isFirst: $isFirst)
                        .tag(2)
                        .tabItem {
                        Image(systemName: "minus")
                    }

                }
                    .tabViewStyle(PageTabViewStyle())
                    .animation(.easeInOut, value: isAnimation)

                CustomPageControl(numberOfPages: numberOfPages, currentPage: $currentPage, isAnimation: $isAnimation)


                Divider()
                    .padding(.vertical, 16)

                Button {
                    currentPage += 1
                    if currentPage > 2 {
                        isFirst.toggle()
                    }
                    isAnimation.toggle()
                } label: {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 240, height: 40)
                            .background(Color(red: 0.13, green: 0.13, blue: 0.13))
                            .cornerRadius(8)

                        Text(currentPage < 2 ? "다음" : "완료")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                }.padding(.bottom, 32)
                
            }
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
        VStack {
            Text("설명글 3번째 화면")
        }
    }
}
struct ModalIntroView_Previews: PreviewProvider {
    static var previews: some View {
        ModalIntroView(isFirst: .constant(true))
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
            .previewDisplayName("iPhone 8")
        ModalIntroView(isFirst: .constant(true))
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
            .previewDisplayName("iPhone 14 Pro")
        
    }
}
