import Foundation

enum Errors: LocalizedError {
    case indexOutOfRange, hasEmptyFields, emailValidation, passwordValidation, nameValidation
    
    var errorDescription: String? {
        switch self {
        case .indexOutOfRange:
            return R.string.localizable.indexOutOfRange()
        }
    }
}
