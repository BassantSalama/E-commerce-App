//
//  AppCoordinator.swift
//  ECommerceApp
//
//  Created by mac on 23/09/2025.
//

import UIKit

class AppFlowCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.viewControllers = []
    }
    
    // MARK: - Child Coordinator Management
    func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.removeAll { $0 === coordinator }
    }
}
