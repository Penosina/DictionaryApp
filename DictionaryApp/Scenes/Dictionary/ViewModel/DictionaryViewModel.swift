import UIKit

final class DictionaryViewModel {
    // MARK: - Properties
    var didSetPlug: ((TopicViewModel) -> Void)?
    var didShowPlug: (() -> Void)?
    var didUpdateData: ((WordViewModel) -> Void)?
    var didReceiveError: ((Error) -> Void)?
    
    private let plugTopicViewModel = TopicViewModel(topicInfo: TopicInfo(
        image: UIImage(named: Images.plug) ?? UIImage(),
        title: Strings.plugTitle,
        subtitle: Strings.plugSubtitle
    ))
    private var wordViewModel: WordViewModel?
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

        dependencies.networkManager.find(word: word) { [weak self] wordModel in
            self?.didUpdateData?(WordViewModel(word: wordModel))
        } onError: { [weak self] error, statusCode in
            self?.didReceiveError?(error)
        }
    }
    
    // MARK: - Private Methods
    
}

// MARK: - Images
private extension Images {
    static let plug = "plug"
}

// MARK: - Strings
private extension Strings {
    static let plugTitle = "No word"
    static let plugSubtitle = "Input something to find it in dictionary"
}
