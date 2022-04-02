import UIKit
final class SignUpCoordinator: Coordinator {
    // MARK: - Properties
    var childCoordinators: [Coordinator]
    var rootNavigationController: UINavigationController
    private let dependencies: Dependencies
    
    init(rootNavigationController: UINavigationController, dependencies: Dependencies) {
        self.dependencies = dependencies
        self.rootNavigationController = rootNavigationController
        childCoordinators = []
    }
    
    // MARK: - Public Methods
    func start() {
        let signUpVC = SignUpViewController()
        rootNavigationController.setViewControllers([signUpVC], animated: true)
    }
}
