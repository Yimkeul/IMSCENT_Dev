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
            NukeUI.LazyImage(url: imgUrl) {
                state in
                if let image = state.image {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 0) {
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
    private func perfumeDesc() -> some View {
        VStack(alignment: .leading) {
            Text(perfume.title)
        }.padding()
    }

}
