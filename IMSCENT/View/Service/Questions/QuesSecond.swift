//
//  QuesSecond.swift
//  IMSCENT
//
//  Created by yimkeul on 2023/09/19.
//

import SwiftUI

struct QuesSecond: View {
    @StateObject var SM = ServiceMethod()
    @StateObject var PA = ProgressAmount()
    @StateObject var PP = PhotoPickerViewModel()
    var body: some View {
        VStack {
            let _ = print("2 init", SM.isSelect)
            // HeadLine
            SM.Title(title: "2) 연령")
            Spacer()
            // 선택
            HStack {
                Button {
                    SM.isSelect[1] = "First"
                    SM.isAnimating.toggle()
                } label: {
                    Text("첫번째 항목")
                }
                Spacer()
                Button {
                    SM.isSelect[1] = "Second"
                    SM.isAnimating.toggle()
                } label: {
                    Text("두번째 항목")
                }
            }.padding(.horizontal, 20)
            // MARK : Trash
            Text("\(SM.isSelect[1] ?? "선택안함")")
            Spacer()
            HStack {
                Button {
                    PA.progressAmont = 0
                    SM.isAnimating.toggle()
                    SM.clearSelect(0)
                    SM.clearSelect(1)
                    print("2) previous :\(SM.isSelect)")
                } label: {
                    SM.previous()
                }
                Spacer()
                Button {
                    PA.progressAmont = 20
                    SM.isAnimating.toggle()
                    print("2) next :\(SM.isSelect)")
                } label: {
                    SM.next(isSelect: SM.isSelect[1])
                }.disabled(SM.isSelect[1] == nil)
            }.padding()
        }
    }
}

struct QuesSecond_Previews: PreviewProvider {
    static var previews: some View {
        QuesSecond()
    }
}
