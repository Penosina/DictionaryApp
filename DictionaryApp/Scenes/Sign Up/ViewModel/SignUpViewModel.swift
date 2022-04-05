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
        
        delegate?.showTabBar()
        return
        
        guard let name = name else {
            didReceiveError?(ValidationError.hasEmptyFields)
            return
        }
        
        guard let email = email else {
            didReceiveError?(ValidationError.hasEmptyFields)
            return
        }
        
        guard let password = password else {
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
