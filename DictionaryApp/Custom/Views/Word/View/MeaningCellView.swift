import UIKit

class MeaningCellView: UITableViewCell {
    // MARK: - Properties
    private let containerView = UIStackView()
    private let definitionLabel = UILabel()
    private let exampleLabel = UILabel()
    private var viewModel: MeaningCellViewModel?
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.borderWidth = 1
        layer.borderColor = Colors.textFieldBorder?.cgColor
        layer.cornerRadius = Dimensions.standart
    }
    
    // MARK: - Public Methods
    func configure(with viewModel: MeaningCellViewModel) {
        setup()
        
        self.viewModel = viewModel
        bindToViewModel()
        self.viewModel?.start()
    }
    
    // MARK: - Private Methods
    private func setup() {
        addSubview(containerView)
        containerView.addSubview(definitionLabel)
        containerView.addSubview(exampleLabel)
        
        setupContainerView()
        setupDefinitionLabel()
        setupExampleLabel()
    }
    
    private func setupContainerView() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Dimensions.standart)
        }
        
        containerView.axis = .vertical
        containerView.spacing = Dimensions.small
    }
    
    private func setupDefinitionLabel() {
        definitionLabel.font = UIFont.rubik(.regular, size: Dimensions.subtitle)
        definitionLabel.textColor = .black
    }
    
    private func setupExampleLabel() {
        exampleLabel.font = UIFont.rubik(.regular, size: Dimensions.subtitle)
    }
    
    private func bindToViewModel() {
        viewModel?.didUpdateData = { [weak self] in
            self?.definitionLabel.text = self?.viewModel?.definitionString
            self?.exampleLabel.attributedText = self?.viewModel?.example
        }
    }
}
