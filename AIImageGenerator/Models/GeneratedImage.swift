//
//  GeneratedImage.swift
//  AIImageGenerator
//
//  Created by Vivianne Sonnerborg on 2025-08-27.
//
//  Represents a generated image in the app.
//  Each image has a unique identifier to support use in SwiftUI lists
//  or other views that require identifiable data.
//

import UIKit

struct GeneratedImage: Identifiable {
    let id = UUID()
    let image: UIImage
}
