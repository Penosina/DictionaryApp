import UIKit

// MARK: - OnboardingCoordinatorDelegate
protocol OnboardingCoordinatorDelegate: AnyObject {
    func removeOnboardingCoordinatorAndShowSignUpScene(onboardingCoordinator: OnboardingCoordinator)
}

final class OnboardingCoordinator: Coordinator {
    // MARK: - Properties
    weak var delegate: OnboardingCoordinatorDelegate?
    
    var childCoordinators: [Coordinator]
    var rootNavigationController: UINavigationController
    
    private let dependencies: Dependencies
    
    // MARK: - Init
    init(rootNavigationController: UINavigationController, dependencies: Dependencies) {
        self.rootNavigationController = rootNavigationController
        self.dependencies = dependencies
        childCoordinators = []
    }
    
    // MARK: - Public Methods
    func start() {
        let onboardingViewModel = OnboardingViewModel()
        onboardingViewModel.delegate = self
        let onboardingVC = OnboardingViewController(viewModel: onboardingViewModel)
        rootNavigationController.setViewControllers([ onboardingVC ], animated: true)
    }
}

// MARK: - OnboardingViewModelDelegate
extension OnboardingCoordinator: OnboardingViewModelDelegate {
    func showRegistrationScene() {
        delegate?.removeOnboardingCoordinatorAndShowSignUpScene(onboardingCoordinator: self)
    }
}
