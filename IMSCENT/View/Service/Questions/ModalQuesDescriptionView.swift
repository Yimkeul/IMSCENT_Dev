//
//  ModalQuesDescriptionView.swift
//  IMSCENT
//
//  Created by yimkeul on 2023/09/21.
//

import SwiftUI

struct ModalQuesDescriptionView: View {
    @Binding var isDesc: Bool
    var body: some View {
        VStack {
            Spacer()
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Spacer()
            Divider()
                .padding(.vertical, 16)

            Button {
                isDesc.toggle()
            } label: {
                ZStack {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 240, height: 40)
                        .background(.black)
                        .cornerRadius(8)

                    Text("확인했습니다")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
            }.padding(.bottom, 32)
        }
    }
}

#Preview {
    ModalQuesDescriptionView(isDesc: .constant(false))
}
