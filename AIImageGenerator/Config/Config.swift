import Foundation

enum Config {
    static var stabilityAIKey: String {
        return Bundle.main.infoDictionary?["STABILITY_AI_KEY"] as? String ?? ""
    }
}