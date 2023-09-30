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
    let UW = UIScreen.main.bounds.width
    let UH = UIScreen.main.bounds.height

    var body: some View {

        NavigationStack {
            GeometryReader { geo in
                let size = geo.size
                ZStack {
                    Image("HomeBG")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                        .frame(width: UW, height: UH)
                    VStack {
                        ButtonGroup()
                            VStack (spacing : 0){
                                Image("Logo")
                                    .renderingMode(.template)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 200, height:150)
                                    .clipShape(Rectangle())
                                    .foregroundColor(.white)
                                Text("패션에 향을 더하다")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.white)
                                    .offset(y : -30)
                                Spacer()
                            }
                        Spacer()
                        ButtonStart(width: size.width, height: 60).padding(.bottom, 32)
                    }
                    .frame(width: size.width, height: size.height)
                }
                .frame(width: size.width, height: size.height)
            }.padding()
        }
    }


    @ViewBuilder
    private func ButtonStart(width: Double, height: Double) -> some View {
        Button {
            navService.toggle()
        } label: {
//            ZStack {
//                Rectangle()
//                    .foregroundColor(.clear)
//                    .frame(width: width, height: height)
//                    .background(.black)
//                    .cornerRadius(8)
//
            Text("향수 추천받기")
                .font(.system(size: 24))
                .fontWeight(.semibold)
                .foregroundColor(.white)
//            }
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

#Preview {
    HomeView()
}
