//
//  QuesFirst.swift
//  IMSCENT
//
//  Created by yimkeul on 2023/09/19.
//

import SwiftUI

struct QuesFirst: View {
    @StateObject var SM = ServiceMethod()
    @StateObject var PA = ProgressAmount()
    @StateObject var PP = PhotoPickerViewModel()
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                VStack {
                    SM.Title(title: "성별을 선택해 주세요")
                        .padding(.bottom, 16)
                    Spacer()
                    SM.TitleImage(image: "bubbles", width: geo.size.width * 0.4, height: geo.size.width * 0.4)
                    Spacer()
                } .frame(width: geo.size.width, height: geo.size.height * 0.5)
                // MARK: 절반
                VStack {
                    Spacer()
                    buttonBox()
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            Task {
                                PA.progressAmont = 10
                                SM.isAnimating.toggle()
                                print("1) next :\(SM.isSelect)")
                            }
                        } label: {
                            SM.next(isSelect: SM.isSelect[0])
                        }.disabled(SM.isSelect[0] == nil)
                    }
                }
                    .padding()
                    .frame(width: geo.size.width, height: geo.size.height * 0.5)
            }
//            .modifier(CAnimating(isSelectedImageAnimating: false))
        }
    }

    @ViewBuilder
    private func buttonBox() -> some View {
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
