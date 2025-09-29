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
        // Add self to parent's child coordinators
        parentCoordinator?.addChildCoordinator(self)
        
        guard let loginVC = makeLoginViewController() else { return }
        navigationController.pushViewController(loginVC, animated: true)
    }
    
    private func makeLoginViewController() -> LoginViewController? {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        guard let loginVC = storyboard.instantiateViewController(
            withIdentifier: "LoginViewController"
        ) as? LoginViewController else { return nil }
        
        loginVC.viewModel = LoginDIContainer.shared.getLoginViewModel(coordinator: self)
        return loginVC
    }
}
