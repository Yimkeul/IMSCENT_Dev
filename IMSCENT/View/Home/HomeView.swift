//
//  ContentView.swift
//  IMSCENT
//
//  Created by yimkeul on 2023/09/16.
//

import SwiftUI

struct HomeView: View {

    @AppStorage("isFirst") var isFirst: Bool = true
    @State private var navService: Bool = false
    var body: some View {
        NavigationStack {
            GeometryReader {
                geo in
                VStack {
                    // MARK: 버튼 그룹
                    ButtonGroup()
                    Spacer()
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                    Spacer().frame(height: geo.size.height*0.4)
                    ButtonStart().padding(.bottom, geo.size.height*0.1)
                }
                    .frame(width: geo.size.width, height: geo.size.height)

            }.padding()

        }
    }

    @ViewBuilder
    private func ButtonStart() -> some View {
        Button {
            navService.toggle()
            print("시작하기. \(navService.description)")
        } label: {
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 240, height: 40)
                    .background(Color(red: 0.13, green: 0.13, blue: 0.13))
                    .cornerRadius(8)

                Text("시작하기")
                    .font(
                    Font.custom("SF Pro Text", size: 16)
                        .weight(.semibold)
                )
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
            }
        }
        .navigationDestination(isPresented: $navService) {
            ServiceView_1()
                
        }
    }

    @ViewBuilder
    private func ButtonGroup() -> some View {
        HStack {
            Spacer()
            Button {
                isFirst.toggle()
            } label: {
                Image(systemName: "questionmark.circle")
                    .foregroundColor(Color.black)
                    .imageScale(.large)
            }.sheet(isPresented: $isFirst) {
                ModalIntroView(isFirst: $isFirst)
                    .presentationDetents([.fraction(0.9)])
                    .presentationDragIndicator(.visible)
            }.padding(.trailing, 16)

            Button {
                isFirst.toggle()
            } label: {
                Image(systemName: "heart")
                    .foregroundColor(Color.black)
                    .imageScale(.large)
            }.sheet(isPresented: $isFirst) {
                ModalIntroView(isFirst: $isFirst)
                    .presentationDetents([.fraction(0.8)])
                    .presentationDragIndicator(.visible)
            }

        }
    }

}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
//        HomeView()
        HomeView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
            .previewDisplayName("iPhone 8")
        HomeView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
            .previewDisplayName("iPhone 14 Pro")
    }
}