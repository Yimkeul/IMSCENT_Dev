//
//  LikeView.swift
//  IMSCENT
//
//  Created by yimkeul on 2023/10/09.
//

import SwiftUI
import NukeUI

struct LikeListView: View {
    @StateObject private var SavePerfume = SaveViewModel()
    @Environment(\.presentationMode) var presentationMode

    var body: some View {


        NavigationStack {
            VStack {
                customNavBar()
                List {
                    ForEach(SavePerfume.decodeSave(), id: \.self) {
                        perfume in

                        NavigationLink {
                            LikeSelectedView(perfume: perfume)
                                .navigationBarHidden(true)
                        } label: {
                            Text(perfume.title)
                        }

                    }
                }.listStyle(.plain)
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

#Preview {
    LikeListView()
}
