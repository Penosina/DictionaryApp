import Foundation

enum Errors: LocalizedError {
    case indexOutOfRange
    
    var errorDescription: String? {
        switch self {
        case .indexOutOfRange:
            return "Index out of range"
        }
    }
}
