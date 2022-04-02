import UIKit

class VideoViewController: BaseViewController {

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
        
        titleLabel.font = R.font.rubikBold(size: Dimensions.large)
        titleLabel.text = R.string.localizable.comingSoon()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
