import UIKit

class TopicView: UIView {
    // MARK: - Properties
    private let centerImageView = UIImageView()
    private let containerView = UIView()
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
        containerView.addSubview(titleLabel)
        containerView.addSubview(subtitleLabel)
        
        setupCenterImageView()
        setupContainerView()
        setupTitleLabel()
        setupSubtitleLabel()
    }
    
    private func setupCenterImageView() {
        centerImageView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
        }
        
        centerImageView.contentMode = .scaleAspectFill
    }
    
    private func setupContainerView() {
        containerView.snp.makeConstraints { make in
            make.top.equalTo(centerImageView.snp.bottom).offset(Dimensions.standart)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupTitleLabel() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(Dimensions.standart)
        }
        
        titleLabel.textColor = Colors.inkDark
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.rubik(.medium, size: Dimensions.medium)
        titleLabel.numberOfLines = 0
    }
    
    private func setupSubtitleLabel() {
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Dimensions.small)
            make.leading.trailing.equalToSuperview().inset(Dimensions.standart)
            make.bottom.equalToSuperview()
        }
        
        subtitleLabel.textColor = Colors.gray
        subtitleLabel.textAlignment = .center
        subtitleLabel.font = UIFont.rubik(.regular, size: Dimensions.subtitle)
        subtitleLabel.numberOfLines = 0
    }
    
    private func bindToViewModel() {
        viewModel?.didUpdateData = { [weak self] in
            self?.centerImageView.image = self?.viewModel?.image
            self?.titleLabel.text = self?.viewModel?.title
            self?.subtitleLabel.text = self?.viewModel?.subtitle
        }
    }
}
