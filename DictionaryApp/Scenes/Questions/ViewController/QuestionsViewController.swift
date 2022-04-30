import UIKit

class QuestionsViewController: BaseViewController {

    // MARK: - Properties
    private let viewModel: QuestionsViewModel
    
    // MARK: - Init
    init(viewModel: QuestionsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        setup()
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        bindToViewModel()
        view.backgroundColor = .red
    }
    
    // MARK: - Private Methods
    private func setup() {
        
    }
    
    private func bindToViewModel() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
