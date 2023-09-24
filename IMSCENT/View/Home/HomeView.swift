//
//  ContentView.swift
//  IMSCENT
//
//  Created by yimkeul on 2023/09/16.
//

import SwiftUI

struct HomeView: View {
    // 온보딩 모달 제어용
    @AppStorage("isFirst") var isFirst: Bool = true
    // 화면 이동 제어용
    @State private var navService: Bool = false
    @State private var navService2: Bool = false

    @StateObject var SM = ServiceMethod()
    @StateObject var PM = ProgressBarMethod()
    @StateObject var PP = PhotoPickerViewModel()

    var body: some View {
        NavigationStack {
            GeometryReader {
                geo in
                VStack {
                    ButtonGroup()
                    Spacer()
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                    Spacer().frame(height: geo.size.height * 0.4)
                    ButtonStart(width: geo.size.height * 0.5, height: 60).padding(.bottom, 32)
                }
                    .frame(width: geo.size.width, height: geo.size.height)
            }.padding()
        }
    }

    @ViewBuilder
    private func ButtonStart(width:Double, height: Double) -> some View {
        Button {
            navService.toggle()
        } label: {
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: width, height: height)
                    .background(.black)
                    .cornerRadius(8)

                Text("시작하기")
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
        }
            .navigationDestination(isPresented: $navService) {
            ServiceView()
                .navigationBarHidden(true)
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
                navService2.toggle()
            } label: {
                Image(systemName: "heart")
                    .foregroundColor(Color.black)
                    .imageScale(.large)
                    .fontWeight(.semibold)
            } .navigationDestination(isPresented: $navService2) {
                LikeView()
                    .navigationBarHidden(true)
            }

        }
    }

}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
