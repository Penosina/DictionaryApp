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
    
    private let signUpTopicViewModel = TopicViewModel(topicInfo: TopicInfo(
        image: Images.signUpTopicViewImage,
        title: R.string.localizable.signUp(),
        subtitle: R.string.localizable.signUpTopicSubtitle()
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
            didReceiveError?(ValidationError.hasEmptyFields)
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

// MARK: - Images
private extension Images {
    static let signUpTopicViewImage = "signUpImage"
}
