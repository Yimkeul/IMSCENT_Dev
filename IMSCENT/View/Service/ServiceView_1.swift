//
//  ServiceView_1.swift
//  IMSCENT
//
//  Created by yimkeul on 2023/09/17.
//

import SwiftUI

struct ServiceView_1: View {
    @StateObject var PA = ProgressAmount()
    @State private var isAnimating = false
    @State var isClick1: Bool = false
    @State var isClick2: Bool = false


    var body: some View {
        VStack {

            if PA.progressAmont <= 30 {
                ProgressView("테스트", value: PA.progressAmont, total: 30)
                    .padding()
                    .progressViewStyle(RoundedRectProgressViewStyle())
                    .animation(.spring(), value: isAnimating)
            }

            switch PA.progressAmont {
            case 10:
                pageOne()
            case 20:
                pageTwo()
            case 30:
                pageThree()
            default:
                pageLoading()
            }
            Text("aaaa : \(PA.progressAmont)")
        }

    }

    @ViewBuilder
    private func pageOne() -> some View {


        VStack {
            Text("1111111")
            Spacer()
            HStack {
                Button {
                    if isClick1 == false {
                        isClick1 = true
                        isClick2 = false
                    }
                    isAnimating.toggle()
                    print("Click 1", isClick1, isClick2)
                } label: {
                    Text("첫번째 항목")
                }

                Button {
                    if isClick2 == false {
                        isClick2 = true
                        isClick1 = false
                    }
                    isAnimating.toggle()
                    print("Click 2", isClick1, isClick2)
                } label: {
                    Text("두번째 항목")
                }

            }
            Text("\(isClick1.description) || \(isClick2.description)")
            HStack {
                Spacer()
                Button {
                    if PA.progressAmont < 30 {
                        PA.progressAmont += 10
                    }
                    isAnimating.toggle()
                    print(PA.progressAmont)
                } label: {
                    Text("버튼>>")
                }
            }.padding()
        }
    }

    @ViewBuilder
    private func pageTwo() -> some View {
        VStack {
            Text("22222222")
            Spacer()
            HStack {
                Button {
                    if PA.progressAmont > 10 {
                        PA.progressAmont -= 10
                    }
                    isAnimating.toggle()
                    print(PA.progressAmont)
                } label: {
                    Text("<<버튼")
                }
                Spacer()
                Button {
                    if PA.progressAmont < 30 {
                        PA.progressAmont += 10
                    }
                    isAnimating.toggle()
                    print(PA.progressAmont)
                } label: {
                    Text("버튼>>")
                }
            }.padding()
        }
    }

    @ViewBuilder
    private func pageThree() -> some View {
        VStack {
            Text("33333333")
            Spacer()
            HStack {
                Button {
                    if PA.progressAmont > 10 {
                        PA.progressAmont -= 10

                    }
                    isAnimating.toggle()
                    print(PA.progressAmont)
                } label: {
                    Text("<<버튼")
                }
                Spacer()
                Button {
                    if PA.progressAmont <= 30 {
                        PA.progressAmont += 10
                    }
                    print(PA.progressAmont)
                } label: {
                    Text("분석하기")
                }
                Spacer()
            }.padding()
        }
    }

    @ViewBuilder
    private func pageLoading() -> some View {
        VStack {
            ProgressView()
            Spacer()
            Button {
                PA.progressAmont = 10.0
            } label: {
                Text("초기화")
            }
            Text("로딩")


        }
    }
}

struct ServiceView_1_Previews: PreviewProvider {
    static var previews: some View {
        ServiceView_1()
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
            .previewDisplayName("iPhone 8")
        ServiceView_1()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
            .previewDisplayName("iPhone 14 Pro")
    }
}
