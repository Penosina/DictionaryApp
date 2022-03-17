import UIKit
import TPKeyboardAvoiding

class DictionaryViewController: BaseViewController {
    // MARK: - Properties
    private let scrollView = TPKeyboardAvoidingScrollView()
    private let searchTextField = SearchTextField()
    private let plugTopicView = TopicView()
    private let wordView = WordView()
    private let addToDictionaryButton = OrangeRoundedButton()
    private let viewModel: DictionaryViewModel
    
    // MARK: - Actions
    @objc private func addToDictionary() {
        
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
    }
    
    // MARK: - Private Methods
    private func setup() {
        view.addSubview(searchTextField)
        view.addSubview(plugTopicView)
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
        plugTopicView.snp.makeConstraints { make in
            make.leading.trailing.centerY.equalToSuperview()
            make.height.equalTo(plugTopicView.snp.width).multipliedBy(Dimensions.topicViewAspectRatio)
        }
    }
    
    private func setupScrollView() {
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(searchTextField.snp.bottom).offset(Dimensions.standart)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(Dimensions.scrollViewBottomConstraint)
            #warning("Check if not needed")
            make.width.equalToSuperview()
        }
    }
    
    private func setupWordView() {
        wordView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalTo(scrollView.contentLayoutGuide).inset(Dimensions.standart)
        }
    }
    
    private func setupAddToDictionaryButton() {
        addToDictionaryButton.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(Dimensions.buttonHorizontalCostraint)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(Dimensions.buttonVerticalConstraint)
            make.height.equalTo(Dimensions.standartHeight)
        }
        
        addToDictionaryButton.configure(withTitle: Strings.addToDictionary)
    }
    
    private func bindToViewModel() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SearchTextFieldDelegate
extension DictionaryViewController: SearchTextFieldDelegate {
    func search() {
        
    }
}

// MARK: - Dimensions
private extension Dimensions {
    static let buttonHorizontalCostraint = 33.0
    static let buttonVerticalConstraint = 82.0
    static let scrollViewBottomConstraint = 66.0
}

// MARK: - Strings
private extension Strings {
    static let addToDictionary = "Add to Dictionary"
}
