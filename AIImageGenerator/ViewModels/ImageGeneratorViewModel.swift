//  ImageGeneratorViewModel.swift
//  AIImageGenerator
//
//  Created by Vivianne Sonnerborg on 2025-08-27.
//
//  This ViewModel manages the state and logic for generating images
//  using the ImageGeneratorService. It handles user prompts, stores
//  generated images, tracks loading and error states, and manages
//  the currently selected image. It is designed to be used with SwiftUI
//  views and updates the UI reactively via @Published properties.
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
