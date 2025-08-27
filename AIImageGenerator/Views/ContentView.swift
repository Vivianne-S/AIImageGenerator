//
//  ContentView.swift
//  AIImageGenerator
//
//  Created by Vivianne Sonnerborg on 2025-08-27.
//

import SwiftUI

struct ContentView: View {
    @State private var prompt = ""
    
    var body: some View {
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
                
                Button(action: {
                    // placeholder action
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
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
