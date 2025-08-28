//
//  ContentView.swift
//  AIImageGenerator
//
//  Created by Vivianne Sonnerborg on 2025-08-27.
//
//

import SwiftUI
import UIKit

struct ContentView: View {
    @StateObject private var viewModel = ImageGeneratorViewModel()
    @State private var prompt = ""
    @State private var showDownloadAlert = false
    @State private var downloadSuccess = false
    @State private var selectedImage: UIImage? = nil
    
    var body: some View {
        NavigationView {
            ZStack {
                // Gradient background
                LinearGradient(
                    colors: [Color.blue, Color.purple],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                // White translucent circles
                Circle()
                    .fill(Color.white.opacity(0.2))
                    .frame(width: 150, height: 150)
                    .offset(x: -150, y: -200)
                
                Circle()
                    .fill(Color.white.opacity(0.15))
                    .frame(width: 200, height: 200)
                    .offset(x: 150, y: 250)
                
                // Main content
                VStack(spacing: 20) {
                    TextField("Enter prompt...", text: $prompt)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                        .foregroundColor(.purple)
                    
                    Button(action: {
                        viewModel.generate(prompt: prompt)
                        prompt = ""
                    }) {
                        Text("Generate Image")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                LinearGradient(
                                    colors: [Color.purple, Color.blue],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)
                    }
                    .padding(.horizontal)
                    
                    // Loading indicator
                    if viewModel.isLoading {
                        ProgressView()
                            .padding()
                    }
                    
                    // Generated images
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(viewModel.generatedImages) { item in
                                ZStack(alignment: .topTrailing) {
                                    Image(uiImage: item.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxWidth: 300)
                                        .cornerRadius(10)
                                        .shadow(radius: 5)
                                        .padding(.bottom)
                                    
                                    // Download button on each image
                                    Button(action: {
                                        selectedImage = item.image
                                        saveImageToPhotos(item.image)
                                    }) {
                                        Image(systemName: "arrow.down.circle.fill")
                                            .font(.title2)
                                            .foregroundColor(.blue)
                                            .padding(8)
                                            .background(Color.white.opacity(0.9))
                                            .clipShape(Circle())
                                            .shadow(radius: 3)
                                    }
                                    .offset(x: -10, y: 10)
                                }
                            }
                        }
                    }
                    
                    // Error message
                    if let error = viewModel.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .padding()
                    }
                }
                .padding()
            }
            .navigationTitle("AI Image Generator")
            .alert("Image Saved", isPresented: $showDownloadAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(downloadSuccess ?
                     "Image successfully saved to Photos!" :
                     "Failed to save image. Check permissions.")
            }
        }
    }
    
    private func saveImageToPhotos(_ image: UIImage) {
        ImageSaver().writeToPhotoAlbum(image: image) { success, error in
            downloadSuccess = success
            showDownloadAlert = true
            if let error = error {
                print("Save error: \(error.localizedDescription)")
            }
        }
    }
}

// Helper för att spara bilder
class ImageSaver: NSObject {
    private var completion: ((Bool, Error?) -> Void)?
    
    func writeToPhotoAlbum(image: UIImage, completion: @escaping (Bool, Error?) -> Void) {
        self.completion = completion
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @objc private func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        completion?(error == nil, error)
    }
}

#Preview {
    ContentView()
}
