//
//  QuesSecond.swift
//  IMSCENT
//
//  Created by yimkeul on 2023/09/19.
//

import SwiftUI

struct QuesSecond: View {
    @StateObject var SM = ServiceMethod()
    @StateObject var PM = ProgressBarMethod()
    @StateObject var PP = PhotoPickerViewModel()
    @State private var isAnimating: Bool = false
    @State var isAgeRange: Int?

    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                TopArea(width: geo.size.width * 0.4, height: geo.size.height * 0.2)
                Spacer()
                ageRangeBtn()
                Spacer()
                ageDetailBtn()
                Spacer()
                BottomArea()
            }
                .padding()
                .frame(width: geo.size.width, height: geo.size.height)
                .modifier(CAnimating(isAnimating: isAnimating))
        }.onAppear(perform: {
            isAnimating = true
        })
    }

    @ViewBuilder
    private func TopArea(width: Double, height: Double) -> some View {
        VStack {
            SM.Title(title: "나이를 선택해 주세요")
            SM.TitleImage(image: "calendar", width: width, height: height)
        }
    }

    @ViewBuilder
    private func ageRangeBtn() -> some View {
        HStack (spacing: 16) {
            Button {
                isAgeRange = 20
            } label: {
                if isAgeRange == 20 {
                    selectCapsuleBtn(text: "20대")
                } else {
                    unSelectCapsuleBtn(text: "20대")
                }
            }.padding(.leading, 2)

            Button {
                isAgeRange = 30
            } label: {
                if isAgeRange == 30 {
                    selectCapsuleBtn(text: "30대")
                } else {
                    unSelectCapsuleBtn(text: "30대")
                }
            }
            Button {
                isAgeRange = 40
            } label: {
                if isAgeRange == 40 {
                    selectCapsuleBtn(text: "40대")
                } else {
                    unSelectCapsuleBtn(text: "40대")
                }
            }
            Button {
                isAgeRange = 50
            } label: {
                if isAgeRange == 50 {
                    selectCapsuleBtn(text: "50대")

                } else {
                    unSelectCapsuleBtn(text: "50대")
                }
            }
        }
    }

    @ViewBuilder
    private func ageDetailBtn() -> some View {
        switch isAgeRange {
        case .none:
            Circle()
                .stroke(.clear, lineWidth: 2)
                .frame(width: 100)
                .padding()
        default:
            ageDetailButtons()
        }
    }

    @ViewBuilder
    private func ageDetailButtons() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(0 ..< 10) { index in
                    ageDetailButton(age: isAgeRange! + index)
                }
            }
        }
        .modifier(CAnimatingDelay(isAnimating: false, delay: 0, duration: 0.5))
    }

    @ViewBuilder
    private func ageDetailButton(age: Int) -> some View {
        Button {
            SM.isSelect[1] = String(age)
        } label: {
            if SM.isSelect[1] == String(age) {
                selectCircleBtn(text: "\(age)")
            } else {
                unSelectCircleBtn(text: "\(age)")
            }
        }
    }

    @ViewBuilder
    private func BottomArea() -> some View {
        HStack {
            Button {
                Task {
                    PM.progressAmont = 0
                    PM.isAnimating.toggle()
                    SM.clearSelect(0)
                    SM.clearSelect(1)
                    isAgeRange = nil
                    print("2) previous :\(SM.isSelect)")
                }
            } label: {
                SM.previous()
            }
            Spacer()
            Button {
                Task {
                    PM.progressAmont = 20
                    PM.isAnimating.toggle()
                    print("2) next :\(SM.isSelect)")
                }
            } label: {
                SM.next(isSelect: SM.isSelect[1])
            }.disabled(SM.isSelect[1] == nil)
        }
    }

    @ViewBuilder
    private func selectCapsuleBtn (text: String) -> some View {
        ZStack {
            Capsule()
                .stroke(.black, lineWidth: 2)
                .frame(width: 65, height: 30)

            Text(text)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.black)
        }
    }

    @ViewBuilder
    private func unSelectCapsuleBtn (text: String) -> some View {

        ZStack {
            Capsule()
                .stroke(Color.cGray, lineWidth: 2)
                .frame(width: 65, height: 30)


            Text(text)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.gray)
        }
    }

    @ViewBuilder
    private func selectCircleBtn (text: String) -> some View {
        ZStack {
            Circle()
                .stroke(.black, lineWidth: 2)
                .frame(width: 100)

            Text("\(text)세")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.black)
        }.padding()
    }

    @ViewBuilder
    private func unSelectCircleBtn (text: String) -> some View {

        ZStack {
            Circle()
                .stroke(Color.cGray, lineWidth: 2)
                .frame(width: 100)

            Text("\(text)세")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.gray)
        }.padding()
    }


}

struct QuesSecond_Previews: PreviewProvider {
    static var previews: some View {
        QuesSecond()
    }
}
