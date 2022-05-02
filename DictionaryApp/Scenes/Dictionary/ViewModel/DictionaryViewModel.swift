import UIKit

final class DictionaryViewModel {
    // MARK: - Properties
    var didSetPlug: ((TopicViewModel) -> Void)?
    var didShowPlug: (() -> Void)?
    var didUpdateData: ((WordViewModel?) -> Void)?
    var didReceiveError: ((Error) -> Void)?
    
    private let plugTopicViewModel = TopicViewModel(topicInfo: TopicInfo(
        image: Images.plug,
        title: R.string.dictionary.placeholderTitle(),
        subtitle: R.string.dictionary.placeholderSubtitle()
    ))
    private var wordViewModel: WordViewModel? {
        didSet {
            wordViewModel?.delegate = self
        }
    }
    private let dependencies: Dependencies
    
    // MARK: - Init
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Public Methods
    func start() {
        didSetPlug?(plugTopicViewModel)
        didShowPlug?()
    }
    
    func searchWord(word: String?) {
        guard let word = word, !word.isEmpty else {
            didShowPlug?()
            return
        }

        dependencies.wordsRepository.get(word: word) { [weak self] wordModel in
            self?.wordViewModel = WordViewModel(word: wordModel)
            self?.didUpdateData?(self?.wordViewModel)
        } onError: { [weak self] error in
            self?.didReceiveError?(error)
        }
    }
    
    func addToRepository() {
        guard let word = wordViewModel?.word else { return }
        dependencies.wordsRepository.addToRepository(word: word)
    }    
}

// MARK: - WordViewModelDelegate
extension DictionaryViewModel: WordViewModelDelegate {
    func playSound(audioURL: URL) {
        dependencies.audioService.playSound(audioURL: audioURL)
    }
}

// MARK: - Images
private extension Images {
    static let plug = "plug"
}
