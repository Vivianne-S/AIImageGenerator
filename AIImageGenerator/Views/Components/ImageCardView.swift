//
//  ImageCardView.swift
//  AIImageGenerator
//
//  Created by Vivianne Sonnerborg on 2025-08-27.
//
//  A SwiftUI view that displays a single UIImage in a card-style layout.
//  The view scales the image to fit, applies a corner radius and shadow,
//  and adds bottom padding for spacing. Designed for use in lists or
//  galleries of generated images.
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
