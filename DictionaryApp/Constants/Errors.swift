import Foundation

enum Errors: LocalizedError {
    case indexOutOfRange, hasEmptyFields, emailValidation, passwordValidation, nameValidation
    
    var errorDescription: String? {
        switch self {
        case .indexOutOfRange:
            return "Index out of range"
        case .hasEmptyFields:
            return "There are empty fields. Please fill it with data"
        case .emailValidation:
            return "Email should have @"
        case .passwordValidation:
            return "Name should be greater then 6 characters"
        case .nameValidation:
            return "Name should be greater then 3 characters"
        }
    }
}
