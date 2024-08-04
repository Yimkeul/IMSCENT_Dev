//
//  PhotoPickerViewModel.swift
//  IMSCENT
//
//  Created by yimkeul on 2023/09/19.
//


import SwiftUI
import PhotosUI
import CoreML
import Vision

final class PhotoPickerViewModel: ObservableObject {
    @Published private(set) var selectedImage: UIImage? = nil
    @Published var imageSelection: PhotosPickerItem? = nil
    {
        didSet {
//            selectedImage = nil
            setImage(from: imageSelection)
        }
    }

    private func setImage(from selection: PhotosPickerItem?) {
        guard let selection else { return }

        Task {
            do {
                let data = try await selection.loadTransferable(type: Data.self)

                guard let data, let uiImage = UIImage(data: data) else {
                    throw URLError(.badServerResponse)
                }

                DispatchQueue.main.async {
                    self.selectedImage = uiImage
                    print("success : \(data), \(uiImage) , \(String(describing: self.selectedImage))")
                }

                detectFashion(image: uiImage)
            } catch {
                print(error)
            }
        }
    }

    func clearImageData() {
        imageSelection = nil
        selectedImage = nil
    }

    private func detectFashion(image: UIImage?) {
        guard let coreMLModel = try? FashionClassifier(configuration: MLModelConfiguration()),
            let visionModel = try? VNCoreMLModel(for: coreMLModel.model) else {
            print("Error Loading CoreML")
            return
        }
        print(coreMLModel, visionModel)
        // Vision을 이용해 이미치 처리를 요청
        let request = VNCoreMLRequest(model: visionModel) { request, error in
            guard error == nil else {
                fatalError("Failed Request")
            }
            // 식별자의 이름(꽃 이름)을 확인하기 위해 VNClassificationObservation로 변환해준다.
            guard let classification = request.results as? [VNClassificationObservation] else {
                fatalError("Faild convert VNClassificationObservation")
            }
            // 👉 타이틀을 가장 정확도 높은 이름으로 설정
            if let fitstItem = classification.first {
                print(fitstItem.identifier.capitalized)
            }
        }
        #if targetEnvironment(simulator)
            request.usesCPUOnly = true
        #endif



        guard let ciImage = CIImage(image: image!) else {
            fatalError("Cant conver")
        }

        let handler = VNImageRequestHandler(ciImage: ciImage)
        do {
            try handler.perform([request])
        } catch {
            fatalError("no handler")
        }




    }
}


