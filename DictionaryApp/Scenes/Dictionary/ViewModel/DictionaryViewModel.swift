import UIKit

final class DictionaryViewModel {
    // MARK: - Properties
    var didSetPlug: ((TopicViewModel) -> Void)?
    var didUpdateData: (() -> Void)?
    var didReceiveError: ((Error) -> Void)?
    
    private let plugTopicViewModel = TopicViewModel(topicInfo: TopicInfo(
        image: UIImage(named: Images.plug) ?? UIImage(),
        title: Strings.plugTitle,
        subtitle: Strings.plugSubtitle))
    private let dependencies: Dependencies
    
    // MARK: - Init
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Public Methods
    func start() {
        didSetPlug?(plugTopicViewModel)
    }
    
    func searchWord(word: String?) {
        
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
