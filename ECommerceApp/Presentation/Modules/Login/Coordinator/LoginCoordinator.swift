//
//  LoginCoordinator.swift
//  ECommerceApp
//
//  Created by mac on 23/09/2025.
//

import UIKit
import Combine

class LoginCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: Coordinator?
    var loginSuccessPublisher = PassthroughSubject<Void, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    init(navigationController: UINavigationController, parentCoordinator: Coordinator? = nil) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    func start() {
        guard let loginVC = makeLoginViewController() else { return }
        
        loginVC.viewModel.loginSuccess
            .sink { [weak self] in
                self?.loginSuccessPublisher.send()
            }
            .store(in: &cancellables)
        
        navigationController.pushViewController(loginVC, animated: true)
    }
    
    private func makeLoginViewController() -> LoginViewController? {
        let storyboard = UIStoryboard(name: LoginConstants.StoryboardConstants.name, bundle: nil)
        guard let loginVC = storyboard.instantiateViewController(
            withIdentifier: LoginConstants.StoryboardConstants.viewControllerID
        ) as? LoginViewController else { return nil }
        
        loginVC.viewModel = LoginDIContainer.shared.getLoginViewModel(coordinator: self)
        return loginVC
    }
    
    func navigateToSignUp() {
        let signUpCoordinator = SignUpCoordinator(
            navigationController: navigationController,
            parentCoordinator: self
        )
        addChildCoordinator(signUpCoordinator)
        signUpCoordinator.start()
    }
    
    func navigateToForgotPassword() {
        let forgotPasswordCoordinator = ForgotPasswordCoordinator(
            navigationController: navigationController,
            parentCoordinator: self
        )
        addChildCoordinator(forgotPasswordCoordinator)
        forgotPasswordCoordinator.start()
    }

}
