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
    @AppStorage("isDesc") var isDesc: Bool = true
    @StateObject var SM = ServiceMethod()
    @StateObject var PM = ProgressBarMethod()
    @StateObject var PP = PhotoPickerViewModel()
    @State private var isAnimating: Bool = false

    @State private var cISize: Double?
    @State private var cVSize: Double?

    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                TopArea(width: geo.size.width * 0.4, height: geo.size.height * 0.2)
                PickImage(width: geo.size.height * 0.5, height: geo.size.height * 0.5)
                Spacer()
                GoPredictBtn(width: geo.size.height * 0.5, height: 60)
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
            HStack(alignment: .center, spacing: 4) {
                SM.Title(title: "사진을 선택해 주세요")
                Button {
                    isDesc.toggle()
                } label: {
                    Image(systemName: "questionmark.circle")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.black)

                }.sheet(isPresented: $isDesc) {
                    ModalQuesDescriptionView(isDesc: $isDesc)
                        .presentationDetents([.fraction(0.7)])
                        .presentationDragIndicator(.visible)
                }
            }
            
            PhotosPicker(selection: $PP.imageSelection) {
                SM.TitleImage(image: "camera", width: width, height: height) }

        }
    }
    @ViewBuilder
    private func PickImage(width: Double, height: Double) -> some View {
        if let image = PP.selectedImage {
            Image(uiImage: image)
                .resizable()
                .frame(width: width, height: height)
                .cornerRadius(8)
                .scaledToFit()
                .onAppear {
                PM.progressAmont = 30
                SM.isSelect[2] = String(describing: image)
                print("3 appear : \(SM.isSelect)")
                PM.isAnimating.toggle()
                }
        }
    }
    @ViewBuilder
    private func GoPredictBtn(width: Double, height: Double) -> some View {
        if PP.selectedImage != nil {
            Button {
                PM.progressAmont = 40
            } label: {
                ZStack {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: width, height: height)
                        .background(.black)
                    Text("향수 추천받기 👀")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
            }
                .cornerRadius(8)
                .padding(.vertical, 8)
                .modifier(CAnimatingDelay(isAnimating: false, delay: 1, duration: 1.1))
        }
    }
    @ViewBuilder
    private func BottomArea() -> some View {
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
        }
    }

}

struct QuesThird_Previews: PreviewProvider {
    static var previews: some View {
        QuesThird()
    }
}
