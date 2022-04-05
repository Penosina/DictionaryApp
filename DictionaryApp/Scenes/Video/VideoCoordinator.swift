final class VideoCoordinator: TabCoordinator {
    override func start() {
        let videoVC = VideoViewController()
        rootNavigationController.setViewControllers([ videoVC ], animated: true)
    }
}
