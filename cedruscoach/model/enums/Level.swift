import SwiftUI

enum Level: String, CaseIterable, Identifiable {
    case beginner = "Kezdő"
    case medium = "Középhaladó"
    case advanced = "Haladó"

    var id: String { self.rawValue }
    
    var color: Color {
        switch self {
        case .advanced:
            return .red
        case .medium:
            return .blue
        case .beginner:
            return .green
        }
    }
}
