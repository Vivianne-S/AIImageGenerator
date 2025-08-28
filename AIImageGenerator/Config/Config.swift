//
//  Config.swift
//  AIImageGenerator
//
//  Created by Vivianne Sonnerborg on 2025-08-27.
//
//  Provides configuration values for the app, including the API key for Stability AI.
//  The API key is first retrieved from environment variables (useful for testing)
//  and then from Info.plist (or xcconfig) if not found. If no key is available,
//  an empty string is returned and a warning is printed.
//

import Foundation


enum Config {
    static var stabilityAIKey: String {
        if let key = ProcessInfo.processInfo.environment["STABILITY_AI_KEY"] {
            print("Using API key from environment variables")
            return key
        }
        
      
        if let key = Bundle.main.infoDictionary?["STABILITY_AI_KEY"] as? String {
            print("Using API key from Info.plist: \(key.prefix(5))...")
            return key
        }
        
        print("WARNING: No API key found!")
        return ""
    }
}
