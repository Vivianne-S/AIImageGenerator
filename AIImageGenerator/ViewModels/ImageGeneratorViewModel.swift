//  ImageGeneratorViewModel.swift
//  AIImageGenerator
//
//  Created by Vivianne Sonnerborg on 2025-08-27.
//

import Foundation
import SwiftUI
import UIKit

@MainActor
class ImageGeneratorViewModel: ObservableObject {
    @Published var generatedImages: [GeneratedImage] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var selectedImage: GeneratedImage?
    
    private let service = ImageGeneratorService()
    
    func generate(prompt: String) {
        isLoading = true
        errorMessage = nil
        
        service.generateImage(from: prompt) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let image):
                    let newImage = GeneratedImage(image: image)
                    self?.generatedImages.append(newImage)
                    self?.selectedImage = newImage
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func selectImage(_ image: GeneratedImage) {
        selectedImage = image
    }
    
    func clearError() {
        errorMessage = nil
    }
    
    func clearAllImages() {
        generatedImages.removeAll()
        selectedImage = nil
    }
}
