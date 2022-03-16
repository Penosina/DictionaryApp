import UIKit

class DictionaryViewController: BaseViewController {
    // MARK: - Properties
    private let viewModel: DictionaryViewModel
    
    // MARK: - Init
    init(viewModel: DictionaryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - Lifrcycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
