import UIKit

// MARK: - OnboardingViewModelDelegate
protocol OnboardingViewModelDelegate: AnyObject {
    func showSignUpScene()
}

final class OnboardingViewModel {
    // MARK: - Properties
    weak var delegate: OnboardingViewModelDelegate?
    
    var numberOfCells: Int {
        cellViewModels.count
    }
    
    var currentPage: Int = 0 {
        didSet {
            if currentPage == numberOfCells - 1 {
                didUpdateNextButtonTitle?(R.string.localizable.letsStart())
            } else {
                didUpdateNextButtonTitle?(R.string.localizable.next())
            }
            
            didUpdatePageControl?(currentPage)
        }
    }
    
    var didSetDelegates: (() -> Void)?
    var didUpdateNextButtonTitle: ((String) -> Void)?
    var didUpdatePageControl: ((Int) -> Void)?
    var didShowNextPage: ((IndexPath) -> Void)?
    
    private let cellViewModels: [OnboardingCellViewModel] = [
        OnboardingCellViewModel(topicInfo: TopicInfo(
            image: Images.onboardingFirst,
            title: R.string.localizable.onboardingFirstTitle(),
            subtitle: R.string.localizable.onboardingFirstSubtitle()
        )),
        OnboardingCellViewModel(topicInfo: TopicInfo(
            image: Images.onboardingSecond,
            title: R.string.localizable.onboardingSecondTitle(),
            subtitle: R.string.localizable.onboardingSecondSubtitle()
        )),
        OnboardingCellViewModel(topicInfo: TopicInfo(
            image: Images.onboardingThird,
            title: R.string.localizable.onboardingThirdTitle(),
            subtitle: R.string.localizable.onboardingThirdSubtitle()
        ))
    ]
    
    // MARK: - Public Methods
    func start() {
        didSetDelegates?()
    }
    
    func getCellViewModel(atIndex index: Int) throws -> OnboardingCellViewModel {
        guard index < cellViewModels.count else {
            throw Errors.indexOutOfRange
        }
        
        return cellViewModels[index]
    }
    
    func showRegistrationScene() {
        delegate?.showSignUpScene()
    }
    
    func showNextPageOrNextScene() {
        if currentPage == numberOfCells - 1 {
            delegate?.showSignUpScene()
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            didShowNextPage?(indexPath)
        }
    }
    
    func updatePage(currentPage: Int) {
        self.currentPage = currentPage
    }
}

// MARK: - Images
private extension Images {
    static let onboardingFirst = "onboardingFirst"
    static let onboardingSecond = "onboardingSecond"
    static let onboardingThird = "onboardingThird"
}
