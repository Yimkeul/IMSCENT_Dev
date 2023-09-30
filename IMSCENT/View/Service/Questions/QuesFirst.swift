//
//  QuesFirst.swift
//  IMSCENT
//
//  Created by yimkeul on 2023/09/19.
//

import SwiftUI

struct QuesFirst: View {
    @StateObject var SM = ServiceMethod()
    @StateObject var PM = ProgressBarMethod()
    @StateObject var PP = PhotoPickerViewModel()
    @State private var isAnimating: Bool = false

    var body: some View {

        GeometryReader { geo in
            let size = geo.size
            VStack {
                TopArea(height: size.height * 0.2)
                Spacer()
                SelectBox()
                Spacer()
                BottomArea()
            }
                .frame(width: size.width, height: size.height)
                .modifier(CAnimating(isAnimating: isAnimating))
                .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                    isAnimating = true
                })
            }
        }

    }

    @ViewBuilder
    private func TopArea(height: Double) -> some View {
        VStack(spacing: 0) {
            SM.Title(title: "성별을 선택해 주세요")
            SM.TitleImage(image: "hands", height: height)
        }
    }
    @ViewBuilder
    private func SelectBox() -> some View {
        HStack(spacing: 16) {
            Button {
                SM.isSelect[0] = "male"
            } label: {
                if SM.isSelect[0] == "male" {
                    selectRRBtn(text: "남성")
                } else {
                    unSelectRRBtn(text: "남성")
                }

            }
            Button {
                SM.isSelect[0] = "female"
            } label: {
                if SM.isSelect[0] == "female" {
                    selectRRBtn(text: "여성")
                } else {
                    unSelectRRBtn(text: "여성")
                }

            }
        }

    }
    @ViewBuilder
    private func BottomArea() -> some View {
        HStack {
            Spacer()
            Button {
                Task {
                    PM.progressAmont = 10
                    PM.isAnimating.toggle()
                    print("1) next :\(SM.isSelect)")
                }
            } label: {
                SM.next(isSelect: SM.isSelect[0])
            }.disabled(SM.isSelect[0] == nil)
        }.padding()
    }
    @ViewBuilder
    private func selectRRBtn (text: String) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .stroke(.black, lineWidth: 2)
                .frame(width: 150, height: 50)
            Text(text)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.black)
        }
    }
    @ViewBuilder
    private func unSelectRRBtn (text: String) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.cGray, lineWidth: 2)
                .frame(width: 150, height: 50)
            Text(text)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.gray)
        }
    }
}

struct QuesFirst_Previews: PreviewProvider {
    static var previews: some View {
        QuesFirst()
    }
}
