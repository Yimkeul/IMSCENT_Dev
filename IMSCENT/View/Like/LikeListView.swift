//
//  LikeView.swift
//  IMSCENT
//
//  Created by yimkeul on 2023/10/09.
//

import SwiftUI
import NukeUI

struct LikeListView: View {
    @StateObject var SavePerfume = SaveViewModel()
    @Environment(\.presentationMode) var presentationMode

    @State private var showDeleteAlert = false
    @State private var target: Int = 0
    let UH = UIScreen.main.bounds.height
    let UW = UIScreen.main.bounds.width

    var body: some View {
        VStack {
            customNavBar()
            if SavePerfume.decodeSave().count > 0 {
                ScrollView {
                    Spacer().frame(height: 16)
                    ForEach(SavePerfume.decodeSave().reversed(), id: \.self) {
                        perfume in
                        let imgUrl: URL = URL(string: perfume.imglink)!
                        NukeUI.LazyImage(url: imgUrl) { state in
                            if let image = state.image {
                                ZStack {
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: UW - 32, height: 270)
                                        .cornerRadius(20)
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Spacer()
                                            Button {
                                                showDeleteAlert = true
                                                target = perfume.idx
                                            } label: {
                                                Image(systemName: "trash")
                                                    .foregroundColor(.black)
                                                    .imageScale(.medium)
                                                    .fontWeight(.semibold)
                                            }
                                            .padding()
                                                .alert(isPresented: $showDeleteAlert) {
                                                Alert(
                                                    title: Text("삭제"),
                                                    message: Text("정말로 삭제하시겠습니까?"),
                                                    primaryButton: .default(Text("닫기"), action: { showDeleteAlert = false }),
                                                    secondaryButton: .destructive(Text("삭제"), action: {
                                                        withAnimation {
                                                            SavePerfume.popIDSave(idx: target)
                                                        }
                                                    })
                                                )
                                            }
                                        }
                                        Spacer()
                                        VStack(alignment: .leading) {
                                            Text(perfume.maker)
                                                .font(.system(size: 10, weight: .semibold))
                                            Text(perfume.title)
                                                .font(.system(size: 16, weight: .bold))
                                            Text(perfume.type)
                                                .font(.system(size: 12, weight: .medium))
                                                .foregroundStyle(Color.cPGray)
                                        }
                                        .padding()
                                    }
                                }
                                .padding(.horizontal, 16)
                                .padding(.bottom, 16)
                                
                            } else {
                                Spacer()
                                    .frame(width: UW - 64, height: 250)
                            }
                        }
                    }
                }
                    .offset(y: -7)
                    .scrollIndicators(ScrollIndicatorVisibility.hidden)
            } else {
                Text("저장된 데이터가 없습니다.")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color.cPGray)
                    .padding(.top, 16)
                Spacer()
            }
        }
    }


    @ViewBuilder
    private func customNavBar() -> some View {
        VStack {
            HStack {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrow.backward")
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
                } label: {
                    Image(systemName: "minus.circle")
                        .foregroundColor(.clear)
                        .imageScale(.large)
                        .fontWeight(.semibold)
                        .disabled(true)
                }.frame(width: 24)
            }.padding(.horizontal, 16)

            Divider()
        }

    }
}

#Preview {
    LikeListView()
}
