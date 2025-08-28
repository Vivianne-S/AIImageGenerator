//
//  ImageCardView.swift
//  AIImageGenerator
//
//  Created by Vivianne Sonnerborg on 2025-08-27.
//


import SwiftUI

struct ImageCardView: View {
    let image: UIImage
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFit()
            .frame(maxWidth: 300)
            .cornerRadius(10)
            .shadow(radius: 5)
            .padding(.bottom)
    }
}