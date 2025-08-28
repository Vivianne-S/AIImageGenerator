import Foundation


enum Config {
    static var stabilityAIKey: String {
        // Först kolla i miljövariabler (för test)
        if let key = ProcessInfo.processInfo.environment["STABILITY_AI_KEY"] {
            print("Using API key from environment variables")
            return key
        }
        
        // Sedan kolla i Info.plist (från xcconfig)
        if let key = Bundle.main.infoDictionary?["STABILITY_AI_KEY"] as? String {
            print("Using API key from Info.plist: \(key.prefix(5))...") // Visa bara första tecknen
            return key
        }
        
        print("WARNING: No API key found!")
        return ""
    }
}
