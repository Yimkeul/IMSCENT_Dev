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
    @StateObject var PM = ProgressBarMethod()
    @StateObject var PP = PhotoPickerViewModel()
    @StateObject var TM = TeachableViewModel()
    @StateObject var SC = ServerCheckViewModel()

    @Environment(\.presentationMode) var presentationMode
    

    var body: some View {
        VStack {
            if PM.progressAmont <= 30 {
                customNavBar()
                ProgressView(value: PM.progressAmont, total: 30)
                    .progressViewStyle(RoundedRectProgressViewStyle())
                    .animation(.linear, value: PM.isAnimating)
                    .padding()
            }
            switch PM.progressAmont {
            case 0:
                QuesFirst(SM: SM, PM: PM, PP: PP)
            case 10:
                QuesSecond(SM: SM, PM: PM, PP: PP)
            case 20...30:
                QuesThird(SM: SM, PM: PM, PP: PP, SC: SC)
            default:
                LoadingView(SM: SM, PM: PM, PP: PP)
            }
        }
        .onAppear {
            if SC.getCheck?.success != true {
                SC.startBackgroundCheck()
            }
        }
    }


    @ViewBuilder
    private func customNavBar() -> some View {
        if SM.isLoading != true {
            VStack {
                HStack {
                    Button {
                        clearAll()
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "house")
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
                        print("None")
                    } label: {
                        Image(systemName: "house")
                            .foregroundColor(.clear)
                            .imageScale(.large)
                            .fontWeight(.semibold)
                    }
                    .frame(width: 24)
                    .disabled(true)
                }.padding(.horizontal, 16)

                Divider()
            }
        }

    }

    private func clearAll() {
        PM.progressAmont = 0.0
        SM.clearAll()
        PP.clearImageData()
        TM.clearTMData()
    }
}

struct ServiceView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceView()
    }
}
