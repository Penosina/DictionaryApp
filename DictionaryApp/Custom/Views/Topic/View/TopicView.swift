import UIKit

class TopicView: UIView {
    // MARK: - Properties
    private let centerImageView = UIImageView()
    private let containerView = UIStackView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private var viewModel: TopicViewModel?
   
    // MARK: - Public Methods
    func configure(with viewModel: TopicViewModel) {
        setup()
        
        self.viewModel = viewModel
        bindToViewModel()
        self.viewModel?.setup()
    }
    
    // MARK: - Private Methods
    private func setup() {
        addSubview(centerImageView)
        addSubview(containerView)
        containerView.addArrangedSubview(titleLabel)
        containerView.addArrangedSubview(subtitleLabel)
        
        setupCenterImageView()
        setupContainerView()
        setupTitleLabel()
        setupSubtitleLabel()
    }
    
    private func setupCenterImageView() {
        centerImageView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(centerImageView.snp.width).multipliedBy(Dimensions.imageViewAspectRatio)
        }
        
        centerImageView.image = viewModel?.image
        centerImageView.contentMode = .scaleAspectFill
    }
    
    private func setupContainerView() {
        containerView.snp.makeConstraints { make in
            make.top.equalTo(centerImageView.snp.bottom).offset(Dimensions.standart)
            make.leading.trailing.bottom.equalToSuperview()
        }
    
        containerView.axis = .vertical
        containerView.spacing = Dimensions.small
    }
    
    private func setupTitleLabel() {
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Dimensions.standart)
        }
        
        titleLabel.text = viewModel?.title
        titleLabel.textColor = R.color.inkDark()
        titleLabel.textAlignment = .center
        titleLabel.font = R.font.rubikMedium(size: Dimensions.medium)
        titleLabel.numberOfLines = 0
    }
    
    private func setupSubtitleLabel() {
        subtitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Dimensions.standart)
        }
        
        subtitleLabel.text = viewModel?.subtitle
        subtitleLabel.textColor = R.color.gray()
        subtitleLabel.textAlignment = .center
        subtitleLabel.font = R.font.rubikRegular(size: Dimensions.subtitle)
        subtitleLabel.numberOfLines = 0
    }
    
    private func bindToViewModel() {
        viewModel?.didUpdateData = { [weak self] in
            self?.setup()
        }
    }
}

// MARK: - Dimensions
private extension Dimensions {
    /// 0.7
    static let imageViewAspectRatio = 0.7
}
