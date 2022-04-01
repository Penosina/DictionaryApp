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
        
        let item = UITabBarItem(title: "dictionary_tab_title".localized(),
                                image: UIImage(named: Images.dictionaryTabIcon),
                                selectedImage: nil)
        item.setTitleTextAttributes([
            .font : UIFont.rubik(.regular, size: Dimensions.subtitle)
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
        
        let item = UITabBarItem(title: "training_tab_title".localized(),
                                image: UIImage(named: Images.trainingTabIcon),
                                selectedImage: nil)
        item.setTitleTextAttributes([
            .font : UIFont.rubik(.regular, size: Dimensions.subtitle)
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
        
        let item = UITabBarItem(title: "video_tab_title".localized(),
                                image: UIImage(named: Images.videotabIcon),
                                selectedImage: nil)
        item.setTitleTextAttributes([
            .font : UIFont.rubik(.regular, size: Dimensions.subtitle)
        ], for: .normal)
        
        navController.tabBarItem = item
        
        let videoCoordinator = VideoCoordinator(dependencies: dependencies,
                                                rootNavigationController: navController)
        childCoordinators.append(videoCoordinator)
        videoCoordinator.start()
        
        return navController
    }
}

// MARK: - Images
private extension Images {
    static let dictionaryTabIcon = "dictionaryIcon"
    static let trainingTabIcon = "trainingIcon"
    static let videotabIcon = "videoIcon"
}
