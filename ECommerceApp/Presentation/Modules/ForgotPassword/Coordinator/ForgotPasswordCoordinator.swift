//
//  ForgotPasswordCoordinator.swift
//  ECommerceApp
//
//  Created by mac on 04/10/2025.
//

import UIKit

class ForgotPasswordCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: Coordinator?
    
    init(navigationController: UINavigationController, parentCoordinator: Coordinator? = nil) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    func start() {
        parentCoordinator?.addChildCoordinator(self)
        
        guard let forgotVC = makeForgotPasswordViewController() else { return }
        navigationController.pushViewController(forgotVC, animated: true)
    }
    
    private func makeForgotPasswordViewController() -> ForgotPasswordViewController? {
        let storyboard = UIStoryboard(name: ForgotPasswordConstants.StoryboardConstants.name, bundle: nil)
        guard let forgotVC = storyboard.instantiateViewController(
            withIdentifier: ForgotPasswordConstants.StoryboardConstants.viewControllerID
        ) as? ForgotPasswordViewController else { return nil }
        
        forgotVC.viewModel = ForgotPasswordDIContainer.shared.getForgotPasswordViewModel(coordinator: self)
        return forgotVC
    }
    
    // MARK: - Navigation
    func navigateToLogin() {
        let loginCoordinator = LoginCoordinator(navigationController: navigationController, parentCoordinator: parentCoordinator)
        loginCoordinator.start()
    }
}

