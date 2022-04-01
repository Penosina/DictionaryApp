import UIKit

final class PasswordTextField: CustomTextField {
    // MARK: - Properties
    private let imageView = UIImageView()
    
    // MARK: - Actions
    @objc private func eyeImageViewTapped() {
        isSecureTextEntry = !isSecureTextEntry
        if isSecureTextEntry {
            imageView.image = UIImage(named: Images.closedEye)
        } else {
            imageView.image = UIImage(named: Images.eye)
        }
    }
    
    // MARK: - Override setup()
    override func setup() {
        super.setup()
        
        placeholder = "password".localized()
        padding = UIEdgeInsets(top: Dimensions.standart,
                               left: Dimensions.standart,
                               bottom: Dimensions.standart,
                               right: Dimensions.standartHeight)
        textContentType = .password
        isSecureTextEntry = true
        setupImageView()
    }
    
    // MARK: - Private Methods
    private func setupImageView() {
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview().inset(Dimensions.standart)
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(eyeImageViewTapped))
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: Images.closedEye)
        imageView.addGestureRecognizer(tapGestureRecognizer)
    }
}

// MARK: - Images
private extension Images {
    static let eye = "eye"
    static let closedEye = "closedEye"
}
