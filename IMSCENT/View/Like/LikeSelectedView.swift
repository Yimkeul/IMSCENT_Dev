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
    @State var perfume: resultFilterValue
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
    @ViewBuilder
    private func perfumeDesc() -> some View {
        VStack(alignment: .leading){
//            Text("HHH")
            Text(perfume.title)
            Text(perfume.explain)
        }.padding()
    }
    
}

//#Preview {
//    LikeSelectedView()
//}
