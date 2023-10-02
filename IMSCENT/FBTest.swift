////
////  FBTest.swift
////  IMSCENT
////
////  Created by yimkeul on 2023/10/01.
////
//
//import SwiftUI
//import NukeUI
//
//
//
//struct FBTest: View {
//    @State private var sampleURL: URL?
//    private var sampleURLArray: [URL]?
//    var body: some View {
//        VStack {
//            if sampleURL != nil {
//                NukeUI.LazyImage(url: sampleURL) { state in
//                    if let image = state.image {
//                        image
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width : 200, height : 300)
//                    }
//                    
//                }
//            } else {
//                Text("ddd")
//            }
//        }
//        
//        
//    }
//        
//}
//
//#Preview {
//    FBTest()
//}
