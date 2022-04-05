import UIKit

// MARK: - SignUpViewModelDelegate
protocol SignUpViewModelDelegate: AnyObject {
    func showTabBar()
}

final class SignUpViewModel {
    // MARK: - Properties
    weak var delegate: SignUpViewModelDelegate?
    
    var didReceiveError: ((Error) -> Void)?
    var didUpdateData: ((TopicViewModel) -> Void)?
    
    private let signUpTopicViewModel: TopicViewModel = TopicViewModel(topicInfo: TopicInfo(
        image: UIImage(named: Images.signUpTopicViewImage) ?? UIImage(),
        title: Strings.signUp,
        subtitle: Strings.signUpTopicSubtitle
    ))
    
    // MARK: - Public Methods
    func start() {
        didUpdateData?(signUpTopicViewModel)
    }
    
    func signUp(name: String?, email: String?, password: String?) {
        guard
            let name = name,
            let email = email,
            let password = password else {
            didReceiveError?(Errors.hasEmptyFields)
            return
        }

        let validationErrors = Validator.validateRegistrationFields(email: email,
                                                                    name: name,
                                                                    password: password)
        guard validationErrors.count == 0 else {
            didReceiveError?(validationErrors[0])
            return
        }
        
        delegate?.showTabBar()
    }
}

// MARK: - Strings
private extension Strings {
    static let signUpTopicSubtitle = "Create your account"
}

// MARK: - Images
private extension Images {
    static let signUpTopicViewImage = "signUpImage"
}
