import UIKit

final class TabBarCoordinator: Coordinator {
    var childCoordinators: [Coordinator]
    var rootNavigationController: UINavigationController
    private let dependencies: Dependencies
    
    // MARK: - Init
    init(dependencies: Dependencies, rootNavigationController: UINavigationController) {
        self.dependencies = dependencies
        self.rootNavigationController = rootNavigationController
        childCoordinators = []
    }
    
    // MARK: - Public Methods
    func start() {
        showTabs()
    }
    
    // MARK: - Private Methods
    private func showTabs() {
        let tabBarController = TabBarController()
        
        let dictionaryNavigationController = createDictionaryNavigationController()
        let trainingNavigationController = createTrainingNavigationController()
        let videoNavigationController = createVideoNavigationController()
        
        tabBarController.setViewControllers([ dictionaryNavigationController,
                                              trainingNavigationController,
                                              videoNavigationController],
                                            animated: true)
        
        rootNavigationController.setViewControllers([ tabBarController ], animated: true)
    }
    
    private func createDictionaryNavigationController() -> UINavigationController {
        let navController = UINavigationController()
        navController.isNavigationBarHidden = true
        
        let item = UITabBarItem(title: R.string.localizable.dictionaryTabTitle(),
                                image: R.image.dictionaryIcon(),
                                selectedImage: nil)
        item.setTitleTextAttributes([
            .font : R.font.rubikRegular(size: Dimensions.subtitle) as Any
        ], for: .normal)
        
        navController.tabBarItem = item
        
        let dictionaryCoordinator = DictionaryCoordinator(dependencies: dependencies,
                                                      rootNavigationController: navController)
        childCoordinators.append(dictionaryCoordinator)
        dictionaryCoordinator.start()
        
        return navController
    }
    
    private func createTrainingNavigationController() -> UINavigationController {
        let navController = UINavigationController()
        navController.isNavigationBarHidden = true
        
        let item = UITabBarItem(title: R.string.localizable.trainingTabTitle(),
                                image: R.image.trainingIcon(),
                                selectedImage: nil)
        item.setTitleTextAttributes([
            .font: R.font.rubikRegular(size: Dimensions.subtitle) as Any
        ], for: .normal)
        
        navController.tabBarItem = item
        
        let trainingCoordinator = TrainingCoordinator(dependencies: dependencies,
                                                      rootNavigationController: navController)
        childCoordinators.append(trainingCoordinator)
        trainingCoordinator.start()
        
        return navController
    }
    
    private func createVideoNavigationController() -> UINavigationController {
        let navController = UINavigationController()
        navController.isNavigationBarHidden = true
        
        let item = UITabBarItem(title: R.string.localizable.videoTabTitle(),
                                image: R.image.videoIcon(),
                                selectedImage: nil)
        item.setTitleTextAttributes([
            .font: R.font.rubikRegular(size: Dimensions.subtitle) as Any
        ], for: .normal)
        
        navController.tabBarItem = item
        
        let videoCoordinator = VideoCoordinator(dependencies: dependencies,
                                                rootNavigationController: navController)
        childCoordinators.append(videoCoordinator)
        videoCoordinator.start()
        
        return navController
    }
}
