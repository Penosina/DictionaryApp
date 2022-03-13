import UIKit
import SnapKit

class OnboardingCellView: UICollectionViewCell {
    // MARK: - Properties
    private let topicView = TopicView()
    private var viewModel: OnboardingCellViewModel?
   
    // MARK: - Public Methods
    func configure(with viewModel: OnboardingCellViewModel) {
        setup()
        
        self.viewModel = viewModel
        bindToViewModel()
        self.viewModel?.setup()
    }
    
    // MARK: - Private Methods
    private func setup() {
        addSubview(topicView)
        setupTopicView()
    }
    
    private func setupTopicView() {
        topicView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        topicView.clipsToBounds = true
    }
    
    private func bindToViewModel() {
        viewModel?.didSetTopic = { [weak self] topicViewModel in
            self?.topicView.configure(with: topicViewModel)
        }
    }
}
