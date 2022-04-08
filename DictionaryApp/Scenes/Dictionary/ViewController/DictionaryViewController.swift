import UIKit
import TPKeyboardAvoiding

class DictionaryViewController: BaseViewController {
    // MARK: - Properties
    private let scrollView = TPKeyboardAvoidingScrollView()
    private let searchTextField = SearchTextField()
    private let placeholderTopicView = TopicView()
    private let wordView = WordView()
    private let addToDictionaryButton = OrangeRoundedButton()
    private let viewModel: DictionaryViewModel
    
    // MARK: - Actions
    @objc private func addToDictionary() {
        viewModel.addToRepository()
    }
    
    // MARK: - Init
    init(viewModel: DictionaryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindToViewModel()
        viewModel.start()
    }
    
    // MARK: - Private Methods
    private func setup() {
        view.addSubview(searchTextField)
        view.addSubview(placeholderTopicView)
        view.addSubview(scrollView)
        scrollView.addSubview(wordView)
        view.addSubview(addToDictionaryButton)
        
        setupSearchTextField()
        setupPlugTopicView()
        setupScrollView()
        setupWordView()
        setupAddToDictionaryButton()
    }
    
    private func setupSearchTextField() {
        searchTextField.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(view.safeAreaLayoutGuide).inset(Dimensions.standart)
            make.height.equalTo(Dimensions.standartHeight)
        }
        
        searchTextField.searchDelegate = self
    }
    
    private func setupPlugTopicView() {
        placeholderTopicView.snp.makeConstraints { make in
            make.leading.trailing.centerY.equalToSuperview()
            make.height.equalTo(placeholderTopicView.snp.width).multipliedBy(Dimensions.plugAspectRatio)
        }
    }
    
    private func setupScrollView() {
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(searchTextField.snp.bottom)
        }
    }
    
    private func setupWordView() {
        wordView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(scrollView.contentLayoutGuide).inset(Dimensions.standart)
            make.bottom.equalTo(scrollView.contentLayoutGuide)
            make.width.equalToSuperview()
        }
    }
    
    private func setupAddToDictionaryButton() {
        addToDictionaryButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(Dimensions.buttonHorizontalCostraint)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(Dimensions.standart)
            make.height.equalTo(Dimensions.standartHeight)
        }
        
        addToDictionaryButton.configure(withTitle: R.string.dictionary.addToDictionary())
        addToDictionaryButton.addTarget(self,
                                        action: #selector(addToDictionary),
                                        for: .touchUpInside)
    }
    
    private func bindToViewModel() {
        viewModel.didSetPlug = { [weak self] topicViewModel in
            self?.placeholderTopicView.configure(with: topicViewModel)
        }
        
        viewModel.didShowPlug = { [weak self] in
            self?.wordView.isHidden = true
            self?.addToDictionaryButton.isHidden = true
            self?.placeholderTopicView.isHidden = false
        }
        
        viewModel.didUpdateData = { [weak self] wordViewModel in
            self?.placeholderTopicView.isHidden = true
            self?.wordView.isHidden = false
            self?.addToDictionaryButton.isHidden = false
            self?.wordView.configure(with: wordViewModel)
        }
        
        viewModel.didReceiveError = { [weak self] error in
            self?.showError(error)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SearchTextFieldDelegate
extension DictionaryViewController: SearchTextFieldDelegate {
    func search() {
        viewModel.searchWord(word: searchTextField.text)
    }
}

// MARK: - Dimensions
private extension Dimensions {
    static let plugAspectRatio = 0.92267
}
