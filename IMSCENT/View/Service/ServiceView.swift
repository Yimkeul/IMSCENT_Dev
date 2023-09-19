//
//  ServiceView_1.swift
//  IMSCENT
//
//  Created by yimkeul on 2023/09/17.
//

import SwiftUI
import PhotosUI

struct ServiceView: View {
    @StateObject var SM = ServiceMethod()
    @StateObject var PA = ProgressAmount()
    @StateObject var PP = PhotoPickerViewModel()
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack() {
            customNavBar()
            VStack {
                if PA.progressAmont <= 30 {
                    ProgressView(value: PA.progressAmont, total: 30)
                        .progressViewStyle(RoundedRectProgressViewStyle())
                        .animation(.spring(), value:
                        SM.isAnimating)
                }

                switch PA.progressAmont {
                case 0:
                    pageOne()
                case 10:
                    pageSecond()
                case 20...30:
                    pageThird()
                case 40:
                    pageLoading()
                default:
                    EmptyView()
                }
            }.padding()
        }
    }


    @ViewBuilder
    private func customNavBar() -> some View {
        VStack {
            HStack {
                Button {
                    clearAll()
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "house")
                        .foregroundColor(PA.progressAmont == 40 ? .clear : .black)
                        .imageScale(.large)
                        .fontWeight(.semibold)
                }.disabled(PA.progressAmont == 40 ? true : false)
                
                Spacer()
                
                Image("Logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 122, height: 48)
                    .clipShape(Rectangle())
                
                Spacer()
                
                Button {
                    print("None")
                } label: {
                    Image(systemName: "house")
                        .foregroundColor(.clear)
                        .font(.system(.title, weight: .bold))
                }.disabled(true)
            }.padding(.horizontal, 16)
            
            Divider()
        }
    }


    @ViewBuilder
    private func pageOne() -> some View {
        VStack() {
            let _ = print("1 init", SM.isSelect)
            // HeadLine
            SM.Title(title: "1) 성별")
            Spacer()
            // 선택
            HStack {
                Button {
                    SM.isSelect[0] = "First"
                    SM.isAnimating.toggle()
                } label: {
                    Text("첫번째 항목")
                }
                Spacer()
                Button {
                    SM.isSelect[0] = "Second"
                    SM.isAnimating.toggle()
                } label: {
                    Text("두번째 항목")
                }
            }.padding(.horizontal, 20)
            // MARK : Trash
            Text("\(SM.isSelect[0] ?? "선택안함")")
            Spacer()
            // Nav
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
                }
                    .disabled(SM.isSelect[0] == nil)
            }.padding()
        }
    }

    @ViewBuilder
    private func pageSecond() -> some View {
        VStack {
            let _ = print("2 init", SM.isSelect)
            // HeadLine
            SM.Title(title: "2) 연령")
            Spacer()
            // 선택
            HStack {
                Button {
                    SM.isSelect[1] = "First"
                    SM.isAnimating.toggle()
                } label: {
                    Text("첫번째 항목")
                }
                Spacer()
                Button {
                    SM.isSelect[1] = "Second"
                    SM.isAnimating.toggle()
                } label: {
                    Text("두번째 항목")
                }
            }.padding(.horizontal, 20)
            // MARK : Trash
            Text("\(SM.isSelect[1] ?? "선택안함")")
            Spacer()
            HStack {
                Button {
                    PA.progressAmont = 0
                    SM.isAnimating.toggle()
                    SM.clearSelect(0)
                    SM.clearSelect(1)
                    print("2) previous :\(SM.isSelect)")
                } label: {
                    SM.previous()
                }
                Spacer()
                Button {
                    PA.progressAmont = 20
                    SM.isAnimating.toggle()
                    print("2) next :\(SM.isSelect)")
                } label: {
                    SM.next(isSelect: SM.isSelect[1])
                }.disabled(SM.isSelect[1] == nil)
            }.padding()
        }
    }

    @ViewBuilder
    private func pageThird() -> some View {
        VStack {
            let _ = print("3 init : ", SM.isSelect)

            SM.Title(title: "3) 사진 업로드")
            
            Spacer()
            
            if let image = PP.selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)

                    .onAppear {
                    PA.progressAmont = 30
                    SM.isSelect[2] = String(describing: image)
                    print("3 appear : \(SM.isSelect)")
                    SM.isAnimating.toggle()
                }
            } else {
                Text("이미지 업로드 전")
            }
            
            PhotosPicker(selection: $PP.imageSelection) {
                Text("Open the photo picker")
                    .foregroundColor(.red)
            }
            
            Spacer()
            
            HStack {
                Button {
                    PA.progressAmont = 10
                    SM.isAnimating.toggle()
                    SM.clearSelect(1)
                    SM.clearSelect(2)
                    PP.clearImageData()
                    print("3) previous :\(SM.isSelect)")
                } label: {
                    SM.previous()
                }
                
                Spacer()
                
                Button {
                    PA.progressAmont = 40
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
                clearAll()
            } label: {
                Text("초기화")
            }
            
            Text("로딩")
        }
    }

    private func clearAll() {
        PA.progressAmont = 0.0
        SM.clearAll()
        PP.clearImageData()
    }
}

struct ServiceView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
            .previewDisplayName("iPhone 8")
        ServiceView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
            .previewDisplayName("iPhone 14 Pro")
    }
}
