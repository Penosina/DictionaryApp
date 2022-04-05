import UIKit

final class TopicViewModel {
    // MARK: - Properties
    var image: UIImage? {
        UIImage(named: imageString ?? "")
    }
    var title: String?
    var subtitle: String?
    var didUpdateData: (() -> Void)?
    
    private var imageString: String?
    private let topicInfo: TopicInfo
    
    // MARK: - Init
    init(topicInfo: TopicInfo) {
        self.topicInfo = topicInfo
    }
    
    // MARK: - Public Methods
    func setup() {
        imageString = topicInfo.image
        title = topicInfo.title
        subtitle = topicInfo.subtitle
        
        didUpdateData?()
    }
}
