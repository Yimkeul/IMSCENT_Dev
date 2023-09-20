//
//  QuesSecond.swift
//  IMSCENT
//
//  Created by yimkeul on 2023/09/19.
//

import SwiftUI

struct QuesSecond: View {
    @StateObject var SM = ServiceMethod()
    @StateObject var PA = ProgressAmount()
    @StateObject var PP = PhotoPickerViewModel()

    @State var isAgeRange: Int?

    var body: some View {
        GeometryReader { geo in
            VStack {
                VStack {
                    SM.Title(title: "나이를 선택해 주세요")
                        .padding(.bottom, 16)
                    Spacer()
                    SM.TitleImage(image: "calendar", width: geo.size.width * 0.4, height: geo.size.width * 0.4)
                    Spacer()
                } .frame(width: geo.size.width, height: geo.size.height * 0.5)
                // MARK: 절반
                VStack {

                    ageRangeBtn()
                    Spacer()
                    ageDetailBtn()
                    
                Spacer()
                HStack {
                    Button {
                        Task {
                            PA.progressAmont = 0
                            SM.isAnimating.toggle()
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
                            PA.progressAmont = 20
                            SM.isAnimating.toggle()
                            print("2) next :\(SM.isSelect)")
                        }
                    } label: {
                        SM.next(isSelect: SM.isSelect[1])
                    }.disabled(SM.isSelect[1] == nil)
                }
            }
                .padding()
                .frame(width: geo.size.width, height: geo.size.height * 0.5)
        }
//        .modifier(CAnimating(isSelectedImageAnimating: false))
    }
}
    
    @ViewBuilder
    private func ageRangeBtn() -> some View {
        HStack (spacing: 16){
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
            Spacer()
        }
    }
    
    @ViewBuilder
    private func ageDetailBtn() -> some View {
        switch isAgeRange {
        case .none:
            Circle()
                .stroke(.clear, lineWidth: 2)
                .frame(width: 100)
                .padding(.vertical, 8)
        default:
            ageDetailButtons()
        }
    }

     func ageDetailButtons() -> some View {
         ScrollView(.horizontal , showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(0 ..< 10) { index in
                    ageDetailButton(age: isAgeRange! + index)
                }
            }
            .padding(.vertical, 8)
        }
        .modifier(CAnimatingDelay(isSelectedImageAnimating: false, delay: 0))
    }

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
    }
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
    }
}


}

struct QuesSecond_Previews: PreviewProvider {
    static var previews: some View {
//        QuesSecond()
//            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
//            .previewDisplayName("iPhone 8")
        QuesSecond()
//            .previewDevice(PreviewDevice(rawValue: "iPhone 15 Pro"))
//            .previewDisplayName("iPhone 15 Pro")
    }
}
