//
//  LoginCoordinator.swift
//  ECommerceApp
//
//  Created by mac on 23/09/2025.
//

import UIKit

final class LoginCoordinator: Coordinator {
    var navigationController: UINavigationController
    private let diContainer: LoginDIContainer
    
    init(navigationController: UINavigationController, diContainer: LoginDIContainer) {
        self.navigationController = navigationController
        self.diContainer = diContainer
    }
    
    func start() {
        let loginVC = diContainer.makeLoginViewController()
        navigationController.setViewControllers([loginVC], animated: false)
    }
}
