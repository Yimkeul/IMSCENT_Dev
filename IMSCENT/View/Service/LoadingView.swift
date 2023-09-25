//
//  LoadingView.swift
//  IMSCENT
//
//  Created by yimkeul on 2023/09/26.
//

import SwiftUI

struct LoadingView: View {
    
    @StateObject var SM = ServiceMethod()
    @StateObject var PM = ProgressBarMethod()
    @StateObject var PP = PhotoPickerViewModel()
    @StateObject var TM = TeachableViewModel()
    
    
    var body: some View {
        VStack {
            if TM.getAll?.resultMessage == nil {
                // TODO: 로딩 화면 꾸미기
                ProgressView()
            } else {
                // TODO: 데이터 정재 후 결과화면 꾸미기
                Text(String(describing: TM.getAll?.resultMessage))
            }
            
            Spacer()

            Button {
                clearAll()
            } label: {
                Text("초기화")
            }
        }.task {
            SM.isLoading = true
            processData(uiImage: PP.selectedImage!) { error in
                if let error = error {
                    print("Error : \(error.localizedDescription)")
                } else {
                    print("Processing compoleted successfully")
                }
            }
        }
    }
    
    private func processData(uiImage: UIImage, completion: @escaping (Error?) -> Void) {
        guard let imageData = uiImage.jpegData(compressionQuality: 1.0) else {
            return print("imageData is nil")
        }

        TM.requestAll(imageData: imageData) { teachableResult in
            switch teachableResult {
            case .success:
                SM.isLoading = false
                completion(nil) // 모든 작업이 성공적으로 완료되었을 때
            case .failure(let teachableError):
                completion(teachableError) // teachableModel 요청 중 에러 발생
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

#Preview {
    LoadingView()
}
