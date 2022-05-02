import Foundation

enum ValidationError: LocalizedError {
    case hasEmptyFields, emailValidation, passwordValidation, nameValidation
    
    var errorDescription: String? {
        switch self {
        case .hasEmptyFields:
            return R.string.localizable.emptyFields()
        case .emailValidation:
            return R.string.localizable.emailValidation()
        case .passwordValidation:
            return R.string.localizable.passwordValidation()
        case .nameValidation:
            return R.string.localizable.nameValidation()
        }
    }
}

enum Errors: LocalizedError {
    case indexOutOfRange, emptyDictionary
    
    var errorDescription: String? {
        switch self {
        case .indexOutOfRange:
            return R.string.localizable.indexOutOfRange()
        case .emptyDictionary:
            return ""
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
            return R.string.localizable.alreadyInRepository()
        case .noSuchWordInRepository:
            return R.string.localizable.noSuchWordInRepository()
        }
    }
}
