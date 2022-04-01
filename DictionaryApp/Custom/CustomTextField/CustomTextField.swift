import UIKit

class CustomTextField: UITextField {
    // MARK: - Enum TextFieldState
    enum TextFieldState {
        case name
        case email
    }

    // MARK: - Properties
    var padding = UIEdgeInsets(top: Dimensions.standart,
                               left: Dimensions.standart,
                               bottom: Dimensions.standart,
                               right: Dimensions.standart)
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    // MARK: - Insets Editing
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = Dimensions.medium/2
        layer.borderWidth = 1
        layer.borderColor = Colors.textFieldBorder?.cgColor
    }
    
    // MARK: - Public Methods
    func configure(withState state: TextFieldState) {
        switch state {
        case .email:
            placeholder = "email".localized()
            setupEmailState()
        default:
            placeholder = "name".localized()
            break
        }
    }
    
    func setup() {
        font = UIFont.rubik(.regular, size: Dimensions.subtitle)
        textColor = .black
    }
    
    // MARK: - Private Methods
    private func setupEmailState() {
        keyboardType = .emailAddress
        textContentType = .emailAddress
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Dimensions
private extension Dimensions {
    static let eyeIconPadding = 14.5
}

