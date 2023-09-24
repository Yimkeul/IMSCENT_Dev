//
//  LikeView.swift
//  IMSCENT
//
//  Created by yimkeul on 2023/09/23.
//

import SwiftUI
import ScalingHeaderScrollView
struct LikeView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        GeometryReader { geo in
            VStack {
                customNavBar()
                ScailingView(width :geo.size.width, height: geo.size.height*0.6)
                ButtonStart(width: geo.size.height * 0.5, height: 60).padding(.bottom, 16)
            }.frame(width: geo.size.width, height: geo.size.height)
        }
    }

    @ViewBuilder
    private func customNavBar() -> some View {
        VStack {
            HStack {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "house")
                        .foregroundColor(.black)
                        .imageScale(.large)
                        .fontWeight(.semibold)
                }

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
    private func ScailingView(width : Double, height: Double) -> some View {
        ScalingHeaderScrollView {
            ZStack {
                Rectangle()
                    .fill(.pink)
                    Image("camera")
                        .resizable()
                        .scaledToFit()
            }
        } content: {
            ZStack {
                Color.green
                Text(sample).padding()
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 20, weight: .bold))
            }
        }
        .height(min: height*0.3, max: height)
            .hideScrollIndicators()
            .allowsHeaderCollapse()
    }

    @ViewBuilder
    private func ButtonStart(width: Double, height: Double) -> some View {
        Button {
        } label: {
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: width, height: height)
                    .background(.black)
                    .cornerRadius(8)

                Text("테스트")
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
        }
    }


let sample = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Why do we use it?It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).Where does it come from?Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of `de Finibus Bonorum et Malorum` (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, `Lorem ipsum dolor sit amet..`, comes from a line in section 1.10.32.The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from `de Finibus Bonorum et Malorum` by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham."
}

struct LikeView_Previews: PreviewProvider {
    static var previews: some View {
        LikeView()
    }
}

