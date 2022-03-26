final class Validator {
    static func validateRegistrationFields(email: String, name: String, password: String) -> [Error] {
        var errors: [Error] = []
        
        if !email.contains("@") {
            errors.append(ValidationError.emailValidation)
        }
        
        if name.count < 4 {
            errors.append(ValidationError.nameValidation)
        }
        
        if password.count < 6 {
            errors.append(ValidationError.passwordValidation)
        }
        
        return errors
    }
}
