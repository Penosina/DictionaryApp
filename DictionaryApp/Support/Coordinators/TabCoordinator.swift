import UIKit

class TabCoordinator: Coordinator {
    // MARK: - Properties
    var childCoordinators: [Coordinator]
    var rootNavigationController: UINavigationController
    let dependencies: Dependencies
    
    // MARK: - Init
    init(dependencies: Dependencies, rootNavigationController: UINavigationController) {
        self.dependencies = dependencies
        self.rootNavigationController = rootNavigationController
        rootNavigationController.isNavigationBarHidden = true
        childCoordinators = []
    }
    
    // MARK: - Public Methods
    func start() { }
}
