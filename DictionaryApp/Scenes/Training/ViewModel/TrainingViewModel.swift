import Foundation
import UIKit

protocol TrainingViewModelDelegate: AnyObject {
    func showQuestionScene()
}

final class TrainingViewModel {
    // MARK: - Properties
    var wordsCount: Int {
        words.count
    }
    var trainingText: NSMutableAttributedString?
    lazy var countdownViewModel: CountdownViewModel = {
        let countdownViewModel = CountdownViewModel()
        countdownViewModel.delegate = self
        
        return countdownViewModel
    }()
    
    var didUpdateData: (() -> Void)?
    var didReceiveError: ((Error) -> Void)?
    
    weak var delegate: TrainingViewModelDelegate?
    
    private let dependencies: Dependencies
    private var words: [Word] = []
    
    // MARK: - Init
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Public Methods
    func start() {
        getWords()
    }
    
    func didTappedStartButton() {
        countdownViewModel.makeCount()
    }
    
    // MARK: - Private Methods
    private func getWords() {
        dependencies.wordsRepository.getAll { [weak self] words in
            self?.words = words
            self?.trainingText = self?.getTrainingText()
            self?.didUpdateData?()
        } onError: { [weak self] error in
            self?.didReceiveError?(error)
        }
    }
    
    private func getTrainingText() -> NSMutableAttributedString {
        let firstPart: String
        let lastPart: String
        
        if wordsCount == 0 {
            return NSMutableAttributedString(string: R.string.training.placeholder())
        } else if wordsCount == 1 {
            firstPart = R.string.training.firstPartOneWord()
            lastPart = R.string.training.lastPartOneWord()
        } else {
            firstPart = R.string.training.firstPartManyWords()
            lastPart = R.string.training.lastPartManyWords()
        }
        
        let countString = "\(wordsCount)"
        let mainString = firstPart + countString + lastPart
        let range = (mainString as NSString).range(of: countString)
        
        let mutableAttributedString = NSMutableAttributedString(
            string: mainString,
            attributes: [
                .font: R.font.rubikMedium(size: Dimensions.medium) as Any
            ]
        )
        
        mutableAttributedString.addAttribute(.foregroundColor, value: R.color.orange() as Any, range: range)
        
        return mutableAttributedString
    }
}

// MARK: - CountdownViewModelDelegate
extension TrainingViewModel: CountdownViewModelDelegate {
    func showQuestionScene() {
        delegate?.showQuestionScene()
    }
}
