//
//  ResultView.swift
//  IMSCENT
//
//  Created by yimkeul on 2023/10/02.
//

import SwiftUI
import NukeUI

struct ResultView: View {
    @StateObject var SM = ServiceMethod()
    @StateObject var PM = ProgressBarMethod()
    @StateObject var PP = PhotoPickerViewModel()
    @StateObject var TM = TeachableViewModel()
    @StateObject var RV = RecommandViewModel()

    @StateObject private var SavePerfume = SaveViewModel()

    @Environment(\.presentationMode) var presentationMode
    @State private var navHomeView: Bool = false
    @State private var isAnimating: Bool = false

    let UH = UIScreen.main.bounds.height
    let UW = UIScreen.main.bounds.width
    var body: some View {
        let imgUrl: URL = URL(string: RV.getRecommand!.resultFilter.imglink)!
        VStack {
            customNavBar()
            mainArea(imageUrl: imgUrl)
        }
    }

    @ViewBuilder
    private func customNavBar() -> some View {
        if SM.isLoading != true {
            VStack {
                HStack {
                    Button {
                        clearAll()
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "house")
                            .foregroundColor(.black)
                            .imageScale(.large)
                            .fontWeight(.semibold)
                    }.frame(width: 24)

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
                            .imageScale(.large)
                            .fontWeight(.semibold)
                    }
                        .frame(width: 24)
                        .disabled(true)
                }.padding(.horizontal, 16)

                Divider()
            }
        }

    }

    @ViewBuilder
    private func mainArea(imageUrl: URL) -> some View {
        GeometryReader { geo in
            let size = geo.size
            VStack {
                NukeUI.LazyImage(url: imageUrl) {
                    state in
                    if let image = state.image {
                        GeometryReader { geo in
                            let insize = geo.size
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: insize.width, height: insize.height)
                            VStack {
                                Spacer()
                                Text(RV.getRecommand!.resultFilter.title)
                                    .multilineTextAlignment(.leading)
                                    .font(.system(size: 20, weight: .semibold))
                                    .offset(y: isAnimating ? -32 : 10)
                                    .opacity(isAnimating ? 1 : 0)
                                    .animation(.easeInOut(duration: 0.5).delay(0.5), value: isAnimating)
                                    .onAppear(perform: {
                                    isAnimating = true
                                })
                            }.frame(width: insize.width, height: insize.height)
                        }
                    } else {
                        Spacer()
                    }
                }.offset(y: -6.5)
                Divider()
                    .offset(y: -12.5)
                BottomArea(width: size.width * 0.7, height: 50)
                    .padding(.bottom, 6.5)
            }.frame(width: size.width, height: size.height)
        }
    }

    @ViewBuilder
    private func perfumeDesc() -> some View {
        Text(RV.getRecommand!.resultFilter.title)
            .multilineTextAlignment(.leading)
            .font(.system(size: 20, weight: .semibold))
            .padding()
    }

    @ViewBuilder
    private func BottomArea(width: Double, height: Double) -> some View {

        HStack {
            Spacer()
            Button {
                print("데이터 : \(RV.getRecommand!.resultFilter)")
                if SavePerfume.decodeSave().contains(RV.getRecommand!.resultFilter) {
                    // 이미 저장되어 있는 경우
                    SavePerfume.popLastSave()
                } else {
                    // 저장되어 있지 않은 경우
                    SavePerfume.encodeSave(value: RV.getRecommand!.resultFilter)
                }
            } label: {
                Image(systemName: SavePerfume.decodeSave().contains(RV.getRecommand!.resultFilter) ? "heart.fill" : "heart")
                    .font(.system(size: 20, weight: .bold))
                    .imageScale(.large)
                    .foregroundColor(SavePerfume.decodeSave().contains(RV.getRecommand!.resultFilter) ? .red : .black)
            }

            Spacer()
            ResetBtn(width: width, height: height)
        }

            .padding()
    }

    @ViewBuilder
    private func ResetBtn(width: Double, height: Double) -> some View {
        Button {
            clearAll()
        } label: {
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: width, height: height)
                    .background(.black)
                    .cornerRadius(8)
                Text("다시하기")
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
        }
    }

    private func clearAll() {
        PM.progressAmont = 0.0
        SM.clearAll()
        PP.clearImageData()
        TM.clearTMData()
    }
}

#Preview {
    ResultView()
}
