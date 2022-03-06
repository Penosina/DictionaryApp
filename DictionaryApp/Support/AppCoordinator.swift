import UIKit

final class AppCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator]
    var rootNavigationController: UINavigationController
    private let dependencies: Dependencies
    private let window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
        childCoordinators = []
        rootNavigationController = UINavigationController()
        dependencies = Dependencies(networkManager: NetworkManager())
    }
    
    func start() {
        guard let window = window else { return }
        
        window.rootViewController = rootNavigationController
        window.makeKeyAndVisible()
        
        let startCoordinator = OnboardingCoordinator(rootNavigationController: rootNavigationController, dependencies: dependencies)
        startCoordinator.start()
    }
}
