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
    
    
    let UH = UIScreen.main.bounds.height
    let UW = UIScreen.main.bounds.width
    var body: some View {
        let imgUrl: URL = URL(string: RV.getRecommand!.resultFilter.imglink)!
//          let imgUrl: URL = URL(string: "https://firebasestorage.googleapis.com/v0/b/imscent-39e2f.appspot.com/o/images%2FP4.png?alt=media&token=ac9c8fa7-d52e-4356-85b1-8d9df2b47c88&_gl=1*")!
        
            VStack {
                customNavBar()
                NukeUI.LazyImage(url: imgUrl) {
                    state in
                    if let image = state.image {
                        ScrollView {
                            VStack(alignment: .leading, spacing: 0){
                                image
                                    .resizable()
                                    .scaledToFill()
                                perfumeDesc()
                            }
                        }
                    }
                }
                .offset(y: -9)
                Spacer()
                Divider()
                BottomArea(width: UW * 0.7 , height : 50)
        }
    }

    @ViewBuilder
    private func perfumeDesc() -> some View {
        VStack(alignment: .leading){
//            Text("HHH")
            Text(RV.getRecommand!.resultFilter.title)
            Text(RV.getRecommand!.resultFilter.explain)
        }.padding()
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
                    }

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
                    }.disabled(true)
                }.padding(.horizontal, 16)

                Divider()
            }
        }

    }

    @ViewBuilder
    private func ResetBtn(width: Double, height: Double) -> some View {
        Button {
            print("Hello world")
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
