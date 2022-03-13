import UIKit

// MARK: - OnboardingViewModelDelegate
protocol OnboardingViewModelDelegate: AnyObject {
    func showRegistrationScene()
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
                didUpdateNextButtonTitle?(Strings.letsStart)
            } else {
                didUpdateNextButtonTitle?(Strings.next)
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
            image: UIImage(named: Images.onboardingFirst) ?? UIImage(),
            title: Strings.onboardingFirstTitle,
            subtitle: Strings.onboardingFirstSubtitle
        )),
        OnboardingCellViewModel(topicInfo: TopicInfo(
            image: UIImage(named: Images.onboardingSecond) ?? UIImage(),
            title: Strings.onboardingSecondTitle,
            subtitle: Strings.onboardingSecondSubtitle
        )),
        OnboardingCellViewModel(topicInfo: TopicInfo(
            image: UIImage(named: Images.onboardingThird) ?? UIImage(),
            title: Strings.onboardingThirdTitle,
            subtitle: Strings.onboardingThirdSubtitle
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
        delegate?.showRegistrationScene()
    }
    
    func showNextPageOrNextScene() {
        if currentPage == numberOfCells - 1 {
            delegate?.showRegistrationScene()
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

// MARK: - Strings
private extension Strings {
    static let onboardingFirstTitle = "Learn anytime and anywhere"
    static let onboardingFirstSubtitle = "Quarantine is the perfect time to spend your day learning something new, from anywhere!"
    static let onboardingSecondTitle = "Find a course for you"
    static let onboardingSecondSubtitle = "Quarantine is the perfect time to spend your day learning something new, from anywhere!"
    static let onboardingThirdTitle = "Improve your skills"
    static let onboardingThirdSubtitle = "Quarantine is the perfect time to spend your day learning something new, from anywhere!"
}
