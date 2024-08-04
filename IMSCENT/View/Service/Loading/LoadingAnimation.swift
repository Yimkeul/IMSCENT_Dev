//
//  tempLoadingView.swift
//  IMSCENT
//
//  Created by yimkeul on 2023/09/26.
//

import SwiftUI

struct LoadingAnimation: View {
    @State private var isAnimating: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Color.white
                    .edgesIgnoringSafeArea(.all)
                Image("L1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)

                Image("L2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                    .mask {
                    Rectangle()
                        .frame(width: isAnimating ? 200 : 0)
                        .offset(x: isAnimating ? 0 : -200)
                }
                    .animation(.easeOut(duration: 3).repeatForever(autoreverses: false), value: isAnimating)


                Image("L3")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                    .mask {
                    Rectangle()
                        .frame(width: isAnimating ? 200 : 0)
                        .offset(x: isAnimating ? 0 : -550)
                }.animation(.easeIn(duration: 3).repeatForever(autoreverses: false), value: isAnimating)
            }
                .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                    isAnimating = true
                }) }
                .onDisappear {
                isAnimating = false
            }
            Spacer()
            Text("✨ 향수 검색 중 ✨")
                .font(.system(size: 16, weight: .bold))
                .offset(y: isAnimating ? -10 : 0)
                .animation(
                    .easeIn(duration: 1)
                    .repeatForever(autoreverses: true)
                , value: isAnimating
            )
                .padding(.bottom, 16)
        }
    }
}

#Preview {
    LoadingAnimation()
}
