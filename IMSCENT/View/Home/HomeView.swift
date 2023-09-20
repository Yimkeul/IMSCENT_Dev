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
    @StateObject var PA = ProgressAmount()
    
    
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
                    ButtonStart().padding(.bottom, 32)
                }
                    .frame(width: geo.size.width, height: geo.size.height)

            }.padding()

        }
    }

    @ViewBuilder
    private func ButtonStart() -> some View {
        Button {
            Task{
                navService.toggle()
                PA.progressAmont = 0
                print("시작하기. \(navService.description)")
            }
        } label: {
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 240, height: 40)
                    .background(Color(red: 0.13, green: 0.13, blue: 0.13))
                    .cornerRadius(8)

                Text("시작하기")
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
        }
        .navigationDestination(isPresented: $navService) {
            ServiceView(PA: PA).navigationBarHidden(true)
            let _ = print(PA.progressAmont)
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
                    .fontWeight(.semibold)
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
                    .fontWeight(.semibold)
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
        HomeView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
            .previewDisplayName("iPhone 8")
        HomeView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
            .previewDisplayName("iPhone 14 Pro")
    }
}
