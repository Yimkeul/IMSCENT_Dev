//
//  ServiceView_1.swift
//  IMSCENT
//
//  Created by yimkeul on 2023/09/17.
//

import SwiftUI

struct ServiceView_1: View {
    @StateObject var PA = ProgressAmount()
    @State private var isAnimating = false // 애니메이션 상태를 관리합니다.
    @State private var pageIndex = 0
    @State var isClick1: Bool = false
    @State var isClick2: Bool = false


    var body: some View {
        VStack {
            ProgressView("테스트", value: PA.progressAmont, total: 30)
                .padding()
                .progressViewStyle(RoundedRectProgressViewStyle())
                .onAppear {
                withAnimation {
                    isAnimating = true
                }
            }
        

            switch pageIndex {
            case 0:
                pageOne()
            case 1:
                pageTwo()
            case 2:
                pageThree()
            default:
                pageLoading()
            }
            Text("aaaa : \(PA.progressAmont) , \(pageIndex)")
        }
            .animation(.easeInOut, value: isAnimating) // 애니메이션 활성화 상태에 따라 애니메이션 적용
    }

    @ViewBuilder
    private func pageOne() -> some View {
        
        
        VStack {
            Text("1111111")
            Spacer()
            HStack{
                Button {
                    if isClick1 == false {
                        isClick1 = true
                        isClick2 = false
                    }
                    print("Click 1" , isClick1, isClick2)
                } label: {
                    Text("첫번째 항목")
                }
                
                Button {
                    if isClick2 == false {
                        isClick2 = true
                        isClick1 = false
                    }
                    print("Click 2" , isClick1, isClick2)
                } label: {
                    Text("두번째 항목")
                }

            }
            Text("\(isClick1.description) || \(isClick2.description)")
            HStack {
                Button {
                    if PA.progressAmont > 0 {
                        withAnimation {
                            PA.progressAmont -= 10
                        }
                    }
                    if pageIndex > 0 {
                        pageIndex -= 1
                    }

                    print(PA.progressAmont, pageIndex)
                } label: {
                    Text("<<버튼")
                }
                Spacer()
                Button {
                    if PA.progressAmont < 30 {
                        withAnimation {
                            PA.progressAmont += 10
                        }
                    }
                    if pageIndex < 3 {
                        pageIndex += 1
                    }
                    print(PA.progressAmont, pageIndex)
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
                    if PA.progressAmont > 0 {
                        withAnimation {
                            PA.progressAmont -= 10
                        }
                    }
                    if pageIndex > 0 {
                        pageIndex -= 1
                    }

                    print(PA.progressAmont, pageIndex)
                } label: {
                    Text("<<버튼")
                }
                Spacer()
                Button {
                    if PA.progressAmont < 30 {
                        withAnimation {
                            PA.progressAmont += 10
                        }
                    }
                    if pageIndex < 3 {
                        pageIndex += 1
                    }
                    print(PA.progressAmont, pageIndex)
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
                    if PA.progressAmont > 0 {
                        withAnimation {
                            PA.progressAmont -= 10
                        }
                    }
                    if pageIndex > 0 {
                        pageIndex -= 1
                    }

                    print(PA.progressAmont, pageIndex)
                } label: {
                    Text("<<버튼")
                }
                Spacer()
                Button {
                    if PA.progressAmont < 30 {
                        withAnimation {
                            PA.progressAmont += 10
                        }
                    }
                    if pageIndex < 3 {
                        pageIndex += 1
                    }
                    print(PA.progressAmont, pageIndex)
                } label: {
                    Text("버튼>>")
                }
            }.padding()
        }
    }

    @ViewBuilder
    private func pageLoading()-> some View {
        VStack {
            ProgressView()
            Spacer()
            Button {
                PA.progressAmont = 0.0
                pageIndex = 0
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
