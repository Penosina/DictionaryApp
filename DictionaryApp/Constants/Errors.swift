import Foundation

enum ValidationError: LocalizedError {
    case hasEmptyFields, emailValidation, passwordValidation, nameValidation
    
    var errorDescription: String? {
        switch self {
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

enum Errors: LocalizedError {
    case indexOutOfRange
    
    var errorDescription: String? {
        switch self {
        case .indexOutOfRange:
            return "Index out of range"
        }
    }
}

enum CoreDataError: LocalizedError {
    case invalidManagedObjectType, alreadyInRepository, noSuchWordInRepository
    
    var errorDescription: String? {
        switch self {
        case .invalidManagedObjectType:
            return ""
        case .alreadyInRepository:
            return "Word is already in dictionary"
        case .noSuchWordInRepository:
            return "No such word in repository"
        }
    }
}
