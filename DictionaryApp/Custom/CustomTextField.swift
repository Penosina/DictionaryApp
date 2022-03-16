import UIKit

final class CustomTextField: UITextField {
    enum TextFieldState: String {
        case name = "Name"
        case email = "E-mail"
        case password = "Password"
    }

    // MARK: - Properties
    private var padding = UIEdgeInsets(top: Dimensions.standart,
                                       left: Dimensions.standart,
                                       bottom: Dimensions.standart,
                                       right: Dimensions.standart)
    private let eyeImageView = UIImageView()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    // MARK: - Lifecycle
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = Colors.textFieldBorder?.cgColor
    }
    
    // MARK: - Public Methods
    func configure(withState state: TextFieldState) {
        placeholder = state.rawValue
        
        switch state {
        case .email:
            setupEmailState()
        case .password:
            setupPasswordState()
        default:
            break
        }
    }
    
    // MARK: - Private Methods
    private func setup() {
        font = UIFont.rubik(.regular, size: Dimensions.subtitle)
        textColor = .black
    }
    
    private func setupEmailState() {
        keyboardType = .emailAddress
        textContentType = .emailAddress
    }
    
    private func setupPasswordState() {
        padding = UIEdgeInsets(top: Dimensions.standart,
                               left: Dimensions.standart,
                               bottom: Dimensions.standart,
                               right: 3*Dimensions.standart)
        textContentType = .password
        isSecureTextEntry = true
        setupEyeImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Password State Methods
private extension CustomTextField {
    @objc private func eyeImageViewTapped() {
        isSecureTextEntry = !isSecureTextEntry
        if isSecureTextEntry {
            eyeImageView.image = UIImage(named: Images.closedEye)
        } else {
            eyeImageView.image = UIImage(named: Images.eye)
        }
    }
    
    private func setupEyeImageView() {
        addSubview(eyeImageView)
        eyeImageView.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview().inset(Dimensions.eyeIconPadding)
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(eyeImageViewTapped))
        eyeImageView.isUserInteractionEnabled = true
        eyeImageView.contentMode = .scaleAspectFit
        eyeImageView.image = UIImage(named: Images.closedEye)
        eyeImageView.addGestureRecognizer(tapGestureRecognizer)
    }
}

// MARK: - Images
private extension Images {
    static let eye = "eye"
    static let closedEye = "closedEye"
}

// MARK: - Dimensions
private extension Dimensions {
    static let eyeIconPadding = 14.5
}
