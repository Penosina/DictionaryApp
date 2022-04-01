import Foundation

enum ValidationError: LocalizedError {
    case hasEmptyFields, emailValidation, passwordValidation, nameValidation
    
    var errorDescription: String? {
        switch self {
        case .hasEmptyFields:
            return "empty_fields".localized()
        case .emailValidation:
            return "email_validation".localized()
        case .passwordValidation:
            return "password_validation".localized()
        case .nameValidation:
            return "name_validation".localized()
        }
    }
}

enum Errors: LocalizedError {
    case indexOutOfRange
    
    var errorDescription: String? {
        switch self {
        case .indexOutOfRange:
            return "index_out_of_range".localized()
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
            return "already_in_repository".localized()
        case .noSuchWordInRepository:
            return "no_such_word_in_repository".localized()
        }
    }
}
