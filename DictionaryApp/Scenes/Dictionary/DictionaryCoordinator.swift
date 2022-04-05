final class DictionaryCoordinator: TabCoordinator {
    override func start() {
        let dictionaryViewModel = DictionaryViewModel(dependencies: dependencies)
        let dictionaryVC = DictionaryViewController(viewModel: dictionaryViewModel)
        rootNavigationController.setViewControllers([ dictionaryVC ], animated: true)
    }
}
