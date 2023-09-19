//
//  ServiceView_1.swift
//  IMSCENT
//
//  Created by yimkeul on 2023/09/17.
//

import SwiftUI
import PhotosUI

struct ServiceView: View {
    @StateObject var SM = ServiceMethod()
    @StateObject var PA = ProgressAmount()
    @StateObject var PP = PhotoPickerViewModel()
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack() {
            customNavBar()
            VStack {
                if PA.progressAmont <= 30 {
                    ProgressView(value: PA.progressAmont, total: 30)
                        .progressViewStyle(RoundedRectProgressViewStyle())
                        .animation(.linear, value:
                        SM.isAnimating)
                }

                switch PA.progressAmont {
                case 0:
                    QuesFirst(SM: SM, PA: PA, PP: PP)
                case 10:
                    QuesSecond(SM: SM, PA: PA, PP: PP)
                case 20...30:
                    QuesThird(SM: SM, PA: PA, PP: PP)
                case 40:
                    pageLoading()
                default:
                    EmptyView()
                }
            }.padding()
        }
    }


    @ViewBuilder
    private func customNavBar() -> some View {
        VStack {
            HStack {
                Button {
                    clearAll()
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "house")
                        .foregroundColor(PA.progressAmont == 40 ? .clear : .black)
                        .imageScale(.large)
                        .fontWeight(.semibold)
                }.disabled(PA.progressAmont == 40 ? true : false)
                
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
                        .font(.system(.title, weight: .bold))
                }.disabled(true)
            }.padding(.horizontal, 16)
            
            Divider()
        }
    }
    
    @ViewBuilder
    private func pageLoading() -> some View {
        VStack {
            ProgressView()
            
            Spacer()
            
            Button {
                clearAll()
            } label: {
                Text("초기화")
            }
            
            Text("로딩")
        }
    }

    private func clearAll() {
        PA.progressAmont = 0.0
        SM.clearAll()
        PP.clearImageData()
    }
}

struct ServiceView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
            .previewDisplayName("iPhone 8")
        ServiceView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
            .previewDisplayName("iPhone 14 Pro")
    }
}
