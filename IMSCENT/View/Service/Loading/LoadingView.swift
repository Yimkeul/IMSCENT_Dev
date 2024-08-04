//
//  LoadingView.swift
//  IMSCENT
//
//  Created by yimkeul on 2023/09/26.
//

import SwiftUI
import NukeUI

struct LoadingView: View {

    @StateObject var SM = ServiceMethod()
    @StateObject var PM = ProgressBarMethod()
    @StateObject var PP = PhotoPickerViewModel()
    @StateObject var TM = TeachableViewModel()
    @StateObject var RV = RecommandViewModel()
    @StateObject var SC = ServerCheckViewModel()

    @Environment(\.presentationMode) var presentationMode

    @State private var showErrorAlert = false
    @State private var shouldRetryTask = false

    @State var isCheckServerConnection: Bool = true

    var body: some View {
        VStack {
            // MARK: 로딩 & 에러 알림창.
            if TM.getAll?.resultMessage == nil {
                ProgressView()
            } else {
                VStack {
                    if RV.getRecommand?.resultFilter != nil {
                        ResultView(SM: SM, PM: PM, PP: PP, TM: TM, RV: RV)
                    }
                }.onAppear {
                    Recommand()
                }
            }
        }
            .onAppear {
            SM.isLoading = true
            TeachalbeMachine(uiImage: PP.selectedImage!) { error in
                if let error = error {
                    print("Error : \(error.localizedDescription)")
                    showErrorAlert = true
                    shouldRetryTask = true
                    isCheckServerConnection = false
                } else {
                    print("Processing compoleted successfully")
                    shouldRetryTask = false
                }
            }
        }
    }

    @ViewBuilder
    private func ProgressView() -> some View {
        LoadingAnimation(isCheckServerConnection: $isCheckServerConnection)
            .alert(isPresented: $showErrorAlert) {
            Alert(
                title: Text("오류 발생"),
                message: Text("서버와의 연결이 불안정합니다. 재연결을 시도합니다"),
                primaryButton: .destructive(Text("닫기"), action: {
                    presentationMode.wrappedValue.dismiss()
                }),
                secondaryButton: .default(
                    Text("재시도"),
                    action: {
                        SC.startBackgroundCheck().sink(receiveValue: {
                            success in
                            if success {
                                print("서버 재연결됨")
                                isCheckServerConnection = true
                                TeachalbeMachine(uiImage: PP.selectedImage!) { error in
                                    if let error = error {
                                        print("Error : \(error.localizedDescription)")
                                        print("재시도 안 실패 다시 연결 시도 ")
                                        shouldRetryTask = true
                                        showErrorAlert = true
                                        isCheckServerConnection = false
                                    } else {
                                        print("Processing compoleted successfully")
                                        shouldRetryTask = false
                                    }
                                }
                            } else {
                                print("서버 재연결 실패")
                            }
                        }).store(in: &SC.cancellables)
                    }
                )
            )
        }
    }

    private func TeachalbeMachine(uiImage: UIImage, completion: @escaping (Error?) -> Void) {
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

    private func Recommand() {
        RV.requestRecoomand(sex: SM.isSelect[0]!, age: SM.isSelect[1]!, style: TM.getAll!.resultMessage) {
            result in
            switch result {
            case .success:
                print("success Recommand")
            case .failure(let error):
                print("err : \(error.localizedDescription)")
            }
        }
    }
    
}

#Preview {
    LoadingView()
}
