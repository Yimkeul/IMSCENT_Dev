//
//  QuesThird.swift
//  IMSCENT
//
//  Created by yimkeul on 2023/09/19.
//

import SwiftUI
import PhotosUI

struct QuesThird: View {
    // 온보딩 모달 제어용
//    @AppStorage("isDesc") var isDesc: Bool = true
    @StateObject var SM = ServiceMethod()
    @StateObject var PM = ProgressBarMethod()
    @StateObject var PP = PhotoPickerViewModel()
//    @StateObject var SC = ServerCheckViewModel()
    @State private var isAnimating: Bool = false
    @State private var isServerConnection: Bool = false



    var body: some View {
        GeometryReader { geo in
            let size = geo.size
            VStack {
                TopArea(height: size.height * 0.2)
                GeometryReader { geo in
                    let insize = geo.size
                    PickImage(width: insize.width, height: insize.height)
                }
                BottomArea(width: size.width * 0.7, height: 50)
            }
                .frame(width: size.width, height: size.height)
                .modifier(CAnimating(isAnimating: isAnimating))
        }.onAppear(perform: {
            isAnimating = true
//            SC.startBackgroundCheck().sink(receiveValue: {
//                success in
//                if success {
//                    print("서버 연결됨")
//                    isServerConnection = true
//                } else {
//                    print("서버 재연결 실패")
//                    isServerConnection = false
//                }
//            }).store(in: &SC.cancellables)
        })
    }

    @ViewBuilder
    private func TopArea(height: Double) -> some View {
        VStack {
            HStack(alignment: .center, spacing: 4) {
                SM.Title(title: "사진을 선택해 주세요")
//                Button {
//                    isDesc.toggle()
//                } label: {
//                    Image(systemName: "questionmark.circle")
//                        .font(.system(size: 16, weight: .semibold))
//                        .foregroundColor(.black)
//
//                }.sheet(isPresented: $isDesc) {
//                    ModalQuesDescriptionView(isDesc: $isDesc)
//                        .presentationDetents([.fraction(0.7)])
//                        .presentationDragIndicator(.visible)
//                }
            }

            PhotosPicker(selection: $PP.imageSelection) {
                SM.TitleImage(image: "camera", height: height)
            }
        }

    }
    @ViewBuilder
    private func PickImage(width: CGFloat, height: CGFloat) -> some View {
        if let image = PP.selectedImage {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(width: width, height: height)
                .onAppear (perform: {
                DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                    Task {
                        PM.progressAmont = 30
                        PM.isAnimating.toggle()
                        SM.isSelect[2] = String(describing: image)
                        print("3 appear : \(SM.isSelect)")
                    }
                })
            })
        }
    }


    @ViewBuilder
    private func GoPredictBtn(width: Double, height: Double) -> some View {
//        if isServerConnection {
        // MARK: 서버 연결 성공시
        if PP.selectedImage == nil {
            // 사진 선택 x
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: width, height: height)
                .cornerRadius(8)
        } else {
            // 사진 선택 o
            Button {
                PM.progressAmont = 40
            } label: {
                ZStack {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: width, height: height)
                        .background(.black)
                        .cornerRadius(8)
                    Text("향수 추천받기 👀")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
            }
                .modifier(CAnimatingDelay(isAnimating: false, delay: 0.8, duration: 0.3))
        }
//        }
//        else {
//            // MARK: 서버 연결 실패시
//            ZStack {
//                Rectangle()
//                    .foregroundColor(.clear)
//                    .frame(width: width, height: height)
//                    .background(.clear)
//                    .cornerRadius(8)
//                Text("서버와 연결중...")
//                    .font(.system(size: 20))
//                    .fontWeight(.semibold)
//            }
//        }
    }

    @ViewBuilder
    private func BottomArea(width: Double, height: Double) -> some View {
        HStack {
            Button {
                PM.progressAmont = 10
                PM.isAnimating.toggle()
                SM.clearSelect(1)
                SM.clearSelect(2)
                PP.clearImageData()
                print("3) previous :\(SM.isSelect)")
            } label: {
                SM.previous()
            }

            Spacer()
            GoPredictBtn(width: width, height: height)
        }.padding()
    }

}

struct QuesThird_Previews: PreviewProvider {
    static var previews: some View {
        QuesThird()
    }
}
