import UIKit
final class OnboardingCoordinator: Coordinator {
    var childCoordinators: [Coordinator]
    var rootNavigationController: UINavigationController
    private let dependencies: Dependencies
    
    init(rootNavigationController: UINavigationController, dependencies: Dependencies) {
        self.rootNavigationController = rootNavigationController
        self.dependencies = dependencies
        childCoordinators = []
    }
    
    func start() {
        let vc = ViewController()
        rootNavigationController.pushViewController(vc, animated: true)
    }
}
