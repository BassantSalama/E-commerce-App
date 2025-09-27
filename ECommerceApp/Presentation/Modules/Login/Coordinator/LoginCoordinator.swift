//
//  LoginCoordinator.swift
//  ECommerceApp
//
//  Created by mac on 23/09/2025.
//

import UIKit

class LoginCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        guard let loginVC = makeLoginViewController() else { return }
        navigationController.pushViewController(loginVC, animated: true)
    }
    
    private func makeLoginViewController() -> LoginViewController? {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        
        guard let loginVC = storyboard.instantiateViewController(
            withIdentifier: "LoginViewController"
        ) as? LoginViewController else {
            return nil
        }
        loginVC.viewModel = LoginDIContainer.shared.getLoginViewModel(coordinator: self)
        
        return loginVC
    }
}
