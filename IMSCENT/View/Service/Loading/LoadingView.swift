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

    @Environment(\.presentationMode) var presentationMode

    @State private var showErrorAlert = false
    @State private var errorMessage = "서버와의 연결이 불안정합니다."
    @State private var shouldRetryTask = false

    var body: some View {
        VStack {
            if TM.getAll?.resultMessage == nil {
                Progressing()
                    .alert(isPresented: $showErrorAlert) {
                    Alert(
                        title: Text("오류 발생"),
                        message: Text(errorMessage),
                        primaryButton: .destructive(Text("닫기"), action: {
                            presentationMode.wrappedValue.dismiss()
                        }),
                        secondaryButton: .default(
                            Text("재시도"),
                            action: {
                                if shouldRetryTask {
                                    SM.isLoading = true
                                    processData(uiImage: PP.selectedImage!) { error in
                                        if error != nil {
                                            showErrorAlert = true
                                            shouldRetryTask = true
                                        } else {
                                            print("Processing completed successfully")
                                            shouldRetryTask = false
                                        }

                                    }
                                }
                            }
                        )
                    )
                }
            } else {
                VStack {
                    // TODO: 데이터 정재 후 결과화면 꾸미기
                    Text(String(describing: TM.getAll?.resultMessage))
                    Spacer()

                    Button {
                        clearAll()
                    } label: {
                        Text("초기화")
                    }
                }.padding()
            }
        }
            .task {
            SM.isLoading = true
            processData(uiImage: PP.selectedImage!) { error in
                if let error = error {
                    print("Error : \(error.localizedDescription)")
                    showErrorAlert = true
                    shouldRetryTask = true
                } else {
                    print("Processing compoleted successfully")
                    shouldRetryTask = false
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

//#Preview {
//    LoadingView()
//}
