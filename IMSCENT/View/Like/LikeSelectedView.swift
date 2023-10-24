//
//  LikeSelectedView.swift
//  IMSCENT
//
//  Created by yimkeul on 2023/10/10.
//

import SwiftUI
import NukeUI

struct LikeSelectedView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var SavePerfume = SaveViewModel()

    @State var perfume: resultFilterValue
    @State private var showDeleteAlert = false

    let UH = UIScreen.main.bounds.height
    let UW = UIScreen.main.bounds.width


    var body: some View {
        let imgUrl: URL = URL(string: perfume.imglink)!

        VStack {
            customNavBar()
            mainArea(imageUrl: imgUrl)
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
                    showDeleteAlert.toggle()
                } label: {
                    Image(systemName: "trash")
                        .foregroundColor(.black)
                        .imageScale(.large)
                        .fontWeight(.semibold)
                }
                    .frame(width: 24)
            }
                .alert(isPresented: $showDeleteAlert) {
                Alert(
                    title: Text("삭제"),
                    message: Text("정말로 삭제하시겠습니까?"),
                    primaryButton: .default(Text("닫기"), action: { showDeleteAlert.toggle() }),
                    secondaryButton: .destructive(Text("삭제"), action: {
                        SavePerfume.popIDSave(idx: perfume.idx)
                        presentationMode.wrappedValue.dismiss()

                    }
                    )
                )
            }
                .padding(.horizontal, 16)


            Divider()
        }
    }
    @ViewBuilder
    private func mainArea(imageUrl: URL) -> some View {
        NukeUI.LazyImage(url: imageUrl) { state in
            if let image = state.image {
                VStack (alignment: .center) {
                    ZStack {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: UW * 0.9)
                            .cornerRadius(20)
                            .shadow(
                            color: Color(.black)
                                .opacity(0.4),
                            radius: 8, x: 0, y: 8
                        )
                        VStack {
                            Spacer()
                            Text(perfume.title)
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.white)
                                .font(.largeTitle)
                                .fontWeight(.heavy)
                                .shadow(
                                color: Color(.black)
                                    .opacity(0.15),
                                radius: 2, x: 2, y: 2
                            )
                                .padding(.bottom, 32)
                        }
                    }
                }
                    .padding(16)
            } else {
                Spacer()
            }
        }
    }
}
