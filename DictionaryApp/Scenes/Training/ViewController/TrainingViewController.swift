import UIKit

class TrainingViewController: BaseViewController {

    // MARK: - Properties
    private let titleLabel = UILabel()
    
    // MARK: - Init
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    // MARK: - Private Methods
    private func setup() {
        view.addSubview(titleLabel)
        setupTitleLabel()
    }
    
    private func setupTitleLabel() {
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        titleLabel.font = .rubik(.bold, size: Dimensions.large)
        titleLabel.text = "coming_soon".localized()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
