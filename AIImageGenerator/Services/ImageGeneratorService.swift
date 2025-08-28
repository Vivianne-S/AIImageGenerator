//
//  ImageGeneratorService.swift
//  AIImageGenerator
//
//  Created by Vivianne Sonnerborg on 2025-08-27.
//

import Foundation
import UIKit


// Network errors that can occur during image generation
enum NetworkError: Error {
    case invalidURL
    case noData
    case invalidResponse
    case missingAPIKey
}

class ImageGeneratorService {
    private let apiKey = Config.stabilityAIKey
    private let apiUrl = "https://api.stability.ai/v1/generation/stable-diffusion-xl-1024-v1-0/text-to-image"
    
    func generateImage(from prompt: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        print("API Key available: \(!apiKey.isEmpty)")
        print("Prompt: \(prompt)")
        
        guard !apiKey.isEmpty else {
            completion(.failure(NetworkError.missingAPIKey))
            return
        }
        
        guard let url = URL(string: apiUrl) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.timeoutInterval = 120
        
        let requestBody: [String: Any] = [
            "text_prompts": [
                [
                    "text": prompt,
                    "weight": 1.0
                ]
            ],
            "cfg_scale": 7,
            "height": 1024,
            "width": 1024,
            "steps": 30,
            "samples": 1
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
            print("Request body created successfully")
        } catch {
            completion(.failure(error))
            return
        }
        
        print("Making request to: \(apiUrl)")
        print("Headers: \(request.allHTTPHeaderFields ?? [:])")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            print("HTTP Status Code: \(httpResponse.statusCode)")
            
            guard (200...299).contains(httpResponse.statusCode) else {
                print("Server returned error: \(httpResponse.statusCode)")
                if let data = data, let responseString = String(data: data, encoding: .utf8) {
                    print("Response: \(responseString)")
                }
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            // Debug: skriv ut en del av svaret
            if let responseString = String(data: data, encoding: .utf8)?.prefix(200) {
                print("Response preview: \(responseString)...")
            }
            
            do {
                // Stability AI API returnerar vanligtvis JSON med base64-encoded bilder
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                
                if let artifacts = jsonResponse?["artifacts"] as? [[String: Any]],
                   let firstArtifact = artifacts.first,
                   let base64Image = firstArtifact["base64"] as? String,
                   let imageData = Data(base64Encoded: base64Image),
                   let image = UIImage(data: imageData) {
                    completion(.success(image))
                } else {
                    print("Failed to parse image from response")
                    completion(.failure(NetworkError.invalidResponse))
                }
            } catch {
                print("JSON parsing error: \(error)")
                completion(.failure(error))
            }
        }
        task.resume()
    }}
