import UIKit

final class TopicViewModel {
    // MARK: - Properties
    var image: UIImage?
    var title: String?
    var subtitle: String?
    var didUpdateData: (() -> Void)?
    
    private let topicInfo: TopicInfo
    
    // MARK: - Init
    init(topicInfo: TopicInfo) {
        self.topicInfo = topicInfo
    }
    
    // MARK: - Public Methods
    func setup() {
        image = topicInfo.image
        title = topicInfo.title
        subtitle = topicInfo.subtitle
        
        didUpdateData?()
    }
}
