import UIKit

final class OnboardingCellViewModel {
    // MARK: - Properties
    var didSetTopic: ((TopicViewModel) -> Void)?
    
    private let topicViewModel: TopicViewModel
    
    // MARK: - Init
    init(topicInfo: TopicInfo) {
        topicViewModel = TopicViewModel(topicInfo: topicInfo)
    }
    
    // MARK: - Public Methods
    func setup() {
        didSetTopic?(topicViewModel)
    }
}
