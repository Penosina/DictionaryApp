final class TrainingCoordinator: TabCoordinator {
    override func start() {
        let trainingViewModel = TrainingViewModel(dependencies: dependencies)
        trainingViewModel.delegate = self
        let trainingVC = TrainingViewController(viewModel: trainingViewModel)
        rootNavigationController.setViewControllers([ trainingVC ], animated: true)
    }
}

// MARK: - TrainingViewModelDelegate
extension TrainingCoordinator: TrainingViewModelDelegate {
    func showQuestionScene() {
        
    }
}
