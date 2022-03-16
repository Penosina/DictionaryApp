final class TrainingCoordinator: TabCoordinator {
    override func start() {
        let trainingVC = TrainingViewController()
        rootNavigationController.setViewControllers([ trainingVC ], animated: true)
    }
}
