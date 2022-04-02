import UIKit

final class AppCoordinator: Coordinator {
    // MARK: - Properties
    var childCoordinators: [Coordinator]
    var rootNavigationController: UINavigationController
    private let dependencies: Dependencies
    private let window: UIWindow?
    
    // MARK: - Init
    init(window: UIWindow?) {
        self.window = window
        childCoordinators = []
        dependencies = Dependencies(networkManager: APIService())
        rootNavigationController = UINavigationController()
        rootNavigationController.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: - Public Methods
    func start() {
        guard let window = window else { return }
        
        window.rootViewController = rootNavigationController
        window.makeKeyAndVisible()
        
        let startCoordinator = OnboardingCoordinator(rootNavigationController: rootNavigationController, dependencies: dependencies)
        startCoordinator.delegate = self
        childCoordinators.append(startCoordinator)
        startCoordinator.start()
    }
}

// MARK: - OnboardingCoordinatorDelegate
extension AppCoordinator: OnboardingCoordinatorDelegate {
    func removeOnboardingCoordinatorAndShowSignUpScene(onboardingCoordinator: OnboardingCoordinator) {
        removeAllChildCoordinatorsWithType(type(of: onboardingCoordinator))
        let signUpCoordinator = SignUpCoordinator(rootNavigationController: rootNavigationController, dependencies: dependencies)
        childCoordinators.append(signUpCoordinator)
        signUpCoordinator.start()
    }
}
