import UIKit

class TrainingViewController: BaseViewController {

    // MARK: - Properties
    private let trainingTextLabel = UILabel()
    private let countdownView = CountdownView()
    private let startButton = OrangeRoundedButton()
    private let viewModel: TrainingViewModel
    
    // MARK: - Actions
    @objc private func showQuestionScene() {
        startButton.isHidden = true
        countdownView.isHidden = false
        viewModel.didTappedStartButton()
    }
    
    // MARK: - Init
    init(viewModel: TrainingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindToViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.start()
    }
    
    // MARK: - Private Methods
    private func setup() {
        view.addSubview(trainingTextLabel)
        view.addSubview(countdownView)
        view.addSubview(startButton)
        
        setupTrainingTextLabel()
        setupCountdownView()
        setupStartButton()
    }
    
    private func setupTrainingTextLabel() {
        trainingTextLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Dimensions.standart)
            make.top.lessThanOrEqualTo(view.safeAreaLayoutGuide).inset(Dimensions.titleTop)
            make.bottom.equalTo(startButton.snp.top).offset(-Dimensions.titleBottom)
        }
        
        trainingTextLabel.textAlignment = .center
        trainingTextLabel.numberOfLines = 4
    }
    
    private func setupCountdownView() {
        countdownView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.lessThanOrEqualTo(trainingTextLabel.snp.bottom).offset(Dimensions.titleBottom)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(Dimensions.titleBottom)
        }
        
        countdownView.isHidden = true
        countdownView.configure(with: viewModel.countdownViewModel)
    }
    
    private func setupStartButton() {
        startButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Dimensions.buttonHorizontalCostraint)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(Dimensions.buttonBottomConstraint)
            make.height.equalTo(Dimensions.standartHeight)
        }
        
        startButton.configure(withTitle: R.string.training.startButtonTitle())
        startButton.addTarget(self,
                              action: #selector(showQuestionScene),
                              for: .touchUpInside)
    }
    
    private func bindToViewModel() {
        viewModel.didUpdateData = { [weak self] in
            self?.trainingTextLabel.attributedText = self?.viewModel.trainingText
            self?.startButton.isHidden = self?.viewModel.wordsCount == 0
        }
        
        viewModel.didReceiveError = { [weak self] error in
            self?.showError(error)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Dimensions
private extension Dimensions {
    static let titleTop = 213.0
    static let titleBottom = 171.0
    static let buttonBottomConstraint = 89.0
}
