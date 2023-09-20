//
//  QuesThird.swift
//  IMSCENT
//
//  Created by yimkeul on 2023/09/19.
//

import SwiftUI
import PhotosUI

struct QuesThird: View {
    @StateObject var SM = ServiceMethod()
    @StateObject var PA = ProgressAmount()
    @StateObject var PP = PhotoPickerViewModel()

    var body: some View {
        GeometryReader { geo in
            VStack {
                SM.Title(title: "3) 사진 업로드")
                Spacer()

                ScrollView(showsIndicators: false) {
                    Rectangle()
                        .frame(width: geo.size.width * 0.88, height: geo.size.height * 0.3)
                        .cornerRadius(8)
                        .scaledToFit()
                        .foregroundColor(Color.green)
                    
                    if let image = PP.selectedImage {
                        PhotosPicker(selection: $PP.imageSelection) {
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: geo.size.width * 0.88, height: geo.size.height * 0.55)
                                .cornerRadius(8)
                                .scaledToFit()
                                .onAppear {
                                PA.progressAmont = 30
                                SM.isSelect[2] = String(describing: image)
                                print("3 appear : \(SM.isSelect)")
                                SM.isAnimating.toggle()
                            }
                        }.padding(.bottom, 16)
                    } else {
                        PhotosPicker(selection: $PP.imageSelection) {
                            Image("DefaultImage")
                                .resizable()
                                .frame(width: geo.size.width * 0.88, height: geo.size.height * 0.55)
                                .cornerRadius(8)
                                .scaledToFit()
                                .padding(.bottom, 16)
                        }
                    }
                }
//                .modifier(CAnimating(isSelectedImageAnimating: false))

                Spacer()

                if PP.selectedImage != nil {
                    Button {
                        PA.progressAmont = 40
                    } label: {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: geo.size.width * 0.88, height: 60)
                                .background(Color(red: 0.13, green: 0.13, blue: 0.13))


                            Text("추천 향수 확인하기")
                                .font(.system(size: 20))
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                        }
                    }
                        .cornerRadius(8)
                        .offset(y: SM.isSelectedImageAnimating ? 0 : 20)
                        .opacity(SM.isSelectedImageAnimating ? 1 : 0)
                        .animation(.easeInOut(duration: 1).delay(0.5), value: SM.isSelectedImageAnimating)
                        .onAppear {
                        SM.isSelectedImageAnimating.toggle()
                    }
                        .onDisappear() {
                        SM.isSelectedImageAnimating.toggle()
                    }
                }

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
                }.padding()
            }.frame(width: geo.size.width, height: geo.size.height)
        }
    }
}

struct QuesThird_Previews: PreviewProvider {
    static var previews: some View {
        QuesThird()
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
            .previewDisplayName("iPhone 8")
        QuesThird()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
            .previewDisplayName("iPhone 14 Pro")
    }
}
