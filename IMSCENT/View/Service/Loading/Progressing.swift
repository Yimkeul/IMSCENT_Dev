//
//  tempLoadingView.swift
//  IMSCENT
//
//  Created by yimkeul on 2023/09/26.
//

import SwiftUI

struct Progressing: View {
    @State private var isAnimating: Bool = false
    var body: some View {
            VStack {
                ZStack {
                    Color.black.opacity(0.05)
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
                } .onAppear {
                    isAnimating.toggle()
                }
            }
    }
}

#Preview {
    Progressing()
}
