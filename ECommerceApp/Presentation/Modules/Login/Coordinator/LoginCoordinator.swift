//
//  LoginCoordinator.swift
//  ECommerceApp
//
//  Created by mac on 23/09/2025.
//

import UIKit

// MARK: - LoginCoordinator
class LoginCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: Coordinator?
    
    init(navigationController: UINavigationController, parentCoordinator: Coordinator? = nil) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    func start() {
        parentCoordinator?.addChildCoordinator(self)
        
        guard let loginVC = makeLoginViewController() else { return }
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
    
    // MARK: - Navigation
    func navigateToSignUp() {
        let signUpCoordinator = SignUpCoordinator(navigationController: navigationController,parentCoordinator: self)
        addChildCoordinator(signUpCoordinator)
        signUpCoordinator.start()
    }
}
