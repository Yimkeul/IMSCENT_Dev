//
//  QuesFirst.swift
//  IMSCENT
//
//  Created by yimkeul on 2023/09/19.
//

import SwiftUI

struct QuesFirst: View {
    @StateObject var SM = ServiceMethod()
    @StateObject var PA = ProgressAmount()
    @StateObject var PP = PhotoPickerViewModel()
    
    var body: some View {
        VStack() {
            let _ = print("1 init", SM.isSelect)
            // HeadLine
            SM.Title(title: "1) 성별")
            Spacer()
            // 선택
            HStack {
                Button {
                    SM.isSelect[0] = "First"
                    SM.isAnimating.toggle()
                } label: {
                    Text("첫번째 항목")
                }
                Spacer()
                Button {
                    SM.isSelect[0] = "Second"
                    SM.isAnimating.toggle()
                } label: {
                    Text("두번째 항목")
                }
            }.padding(.horizontal, 20)
            // MARK : Trash
            Text("\(SM.isSelect[0] ?? "선택안함")")
            Spacer()
            // Nav
            HStack {
                Spacer()
                Button {
                    Task {
                        PA.progressAmont = 10
                        SM.isAnimating.toggle()
                        print("1) next :\(SM.isSelect)")
                    }
                } label: {
                    SM.next(isSelect: SM.isSelect[0])
                }
                    .disabled(SM.isSelect[0] == nil)
            }.padding()
        }
    }
}

struct QuesFirst_Previews: PreviewProvider {
    static var previews: some View {
        QuesFirst()
    }
}
