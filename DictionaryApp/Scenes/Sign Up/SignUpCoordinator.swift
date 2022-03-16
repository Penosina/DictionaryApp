import UIKit

// MARK: - SignUpCoordinatorDelegate
protocol SignUpCoordinatorDelegate: AnyObject {
    func removeSignUpCoordinatorAndShowTabBar(signUpCoordinator: SignUpCoordinator)
}

final class SignUpCoordinator: Coordinator {
    // MARK: - Properties
    weak var delegate: SignUpCoordinatorDelegate?
    
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
        let signUpViewModel = SignUpViewModel()
        signUpViewModel.delegate = self
        let signUpVC = SignUpViewController(viewModel: signUpViewModel)
        rootNavigationController.setViewControllers([signUpVC], animated: true)
    }
}

// MARK: - SignUpViewModelDelegate
extension SignUpCoordinator: SignUpViewModelDelegate {
    func showTabBar() {
        delegate?.removeSignUpCoordinatorAndShowTabBar(signUpCoordinator: self)
    }
}
