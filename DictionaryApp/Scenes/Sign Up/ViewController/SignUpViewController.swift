import UIKit
import TPKeyboardAvoiding

class SignUpViewController: BaseViewController {

    // MARK: - Properties
    private let scrollView = TPKeyboardAvoidingScrollView()
    private let signUpTopicView = TopicView()
    private let nameTextField = CustomTextField()
    private let emailTextField = CustomTextField()
    private let passwordTextField = PasswordTextField()
    private let nextButton = OrangeRoundedButton()
    private let viewModel: SignUpViewModel
    
    // MARK: - Actions
    @objc private func signUp() {
        viewModel.signUp(name: nameTextField.text, email: emailTextField.text, password: passwordTextField.text)
    }
    
    // MARK: - Init
    init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        bindToViewModel()
        viewModel.start()
    }
    
    // MARK: - Private Methods
    private func setup() {
        view.addSubview(scrollView)
        scrollView.addSubview(signUpTopicView)
        scrollView.addSubview(nameTextField)
        scrollView.addSubview(emailTextField)
        scrollView.addSubview(passwordTextField)
        view.addSubview(nextButton)
        
        setupScrollView()
        setupSignUpTopicView()
        setupNameTextField()
        setupEmailTextField()
        setupPasswordTextField()
        setupNextButton()
    }
    
    private func setupScrollView() {
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(140)
        }
    }
    
    private func setupSignUpTopicView() {
        signUpTopicView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(scrollView.contentLayoutGuide).inset(Dimensions.standartHeight)
            make.width.equalToSuperview()
            make.height.equalTo(signUpTopicView.snp.width).multipliedBy(Dimensions.signUpTopicViewAspectRatio)
        }
    }
    
    private func setupNameTextField() {
        nameTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Dimensions.standart)
            make.top.equalTo(signUpTopicView.snp.bottom).offset(Dimensions.standart)
            make.height.equalTo(Dimensions.standartHeight)
        }
        
        nameTextField.configure(withState: .name)
    }
    
    private func setupEmailTextField() {
        emailTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Dimensions.standart)
            make.top.equalTo(nameTextField.snp.bottom).offset(Dimensions.standart)
            make.height.equalTo(Dimensions.standartHeight)
        }
        
        emailTextField.configure(withState: .email)
    }
    
    private func setupPasswordTextField() {
        passwordTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Dimensions.standart)
            make.top.equalTo(emailTextField.snp.bottom).offset(Dimensions.standart)
            make.bottom.equalTo(scrollView.contentLayoutGuide).inset(Dimensions.standart)
            make.height.equalTo(Dimensions.standartHeight)
        }
    }
    
    private func setupNextButton() {
        nextButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Dimensions.standart)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(Dimensions.nextButtonBottomAnchor)
            make.height.equalTo(Dimensions.standartHeight)
        }
        
        nextButton.configure(withTitle: Strings.signUp)
        nextButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
    }
    
    private func bindToViewModel() {
        viewModel.didUpdateData = { [weak self] topicViewModel in
            self?.signUpTopicView.configure(with: topicViewModel)
        }
        
        viewModel.didReceiveError = { [weak self] error in
            self?.showError(error)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Dimensions
private extension Dimensions {
    static let signUpTopicViewAspectRatio = 0.88
    static let nextButtonBottomAnchor = 67.0
}
