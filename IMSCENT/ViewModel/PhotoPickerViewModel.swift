//
//  PhotoPickerViewModel.swift
//  IMSCENT
//
//  Created by yimkeul on 2023/09/19.
//


import SwiftUI
import PhotosUI

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
            } catch {
                print(error)
            }
        }
    }
    
    func clearImageData() {
        imageSelection = nil
        selectedImage = nil
    }
}


