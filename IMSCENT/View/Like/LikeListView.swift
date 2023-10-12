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
    @State private var isEditing = false
    @State private var isAnimating = false

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
                    .onDelete(perform: deleteItems)
                }.listStyle(.plain)
                    .environment(\.editMode, isEditing ? .constant(.active) : .constant(.inactive))
                    .animation(.default, value: isAnimating)
            }
        }
    }
    func deleteItems(at offsets: IndexSet) {
        var currentArray = SavePerfume.decodeSave()
        offsets.forEach { index in
            let perfume = currentArray[index]
            currentArray = currentArray.filter { $0.idx != perfume.idx }
        }
        
        if let encodedArray = try? JSONEncoder().encode(currentArray) {
            SavePerfume.SavePerfume = encodedArray
        }
    }


    @ViewBuilder
    private func customNavBar() -> some View {
        VStack {
            HStack{
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
                    isEditing.toggle()
                    isAnimating.toggle()
                } label: {
                    Image(systemName: isEditing ? "minus.circle" : "trash")
                        .foregroundColor(.black)
                        .imageScale(.large)
                        .fontWeight(.semibold)
                }.frame(width: 24)
            }.padding(.horizontal, 16)

            Divider()
        }

    }
}

#Preview {
    LikeListView()
}
