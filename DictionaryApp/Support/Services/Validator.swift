final class Validator {
    static func validateRegistrationFields(email: String, name: String, password: String) -> [Error] {
        var errors: [Error] = []
        
        if !email.contains("@") {
            errors.append(Errors.emailValidation)
        }
        
        if name.count < 4 {
            errors.append(Errors.nameValidation)
        }
        
        if password.count < 6 {
            errors.append(Errors.passwordValidation)
        }
        
        return errors
    }
}
