import UIKit

class MeaningView: UIView {
    // MARK: - Properties
    private let containerView = UIStackView()
    private let definitionLabel = UILabel()
    private let exampleLabel = UILabel()
    private let viewModel: MeaningViewModel
    
    // MARK: - Init
    init(viewModel: MeaningViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setup()
    }
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.borderWidth = 1
        layer.borderColor = R.color.textFieldBorder()?.cgColor
        layer.cornerRadius = Dimensions.standart
    }
    
    // MARK: - Private Methods
    private func setup() {
        addSubview(containerView)
        containerView.addArrangedSubview(definitionLabel)
        containerView.addArrangedSubview(exampleLabel)
        
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
        definitionLabel.font = R.font.rubikRegular(size: Dimensions.subtitle)
        definitionLabel.textColor = .black
        definitionLabel.numberOfLines = 0
        definitionLabel.text = viewModel.definitionString
    }
    
    private func setupExampleLabel() {
        exampleLabel.font = R.font.rubikRegular(size: Dimensions.subtitle)
        exampleLabel.numberOfLines = 0
        exampleLabel.attributedText = viewModel.example
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
