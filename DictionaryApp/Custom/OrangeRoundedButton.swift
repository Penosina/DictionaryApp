import UIKit

class OrangeRoundedButton: UIButton {
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = Dimensions.standart
    }
    
    // MARK: - Public methods
    func configure(withTitle title: String) {
        setTitle(title, for: .normal)
    }
    
    // MARK: - Private Methods
    private func setup() {
        backgroundColor = Colors.orange
        tintColor = Colors.orange
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.rubik(.medium, size: Dimensions.standart)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
