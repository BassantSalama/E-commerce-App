//
//  AppCoordinator.swift
//  ECommerceApp
//
//  Created by mac on 23/09/2025.
//

import UIKit

final class AppFlowCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    private let diContainer: DIContainer
    
    init(navigationController: UINavigationController, diContainer: DIContainer) {
        self.navigationController = navigationController
        self.diContainer = diContainer
    }
    
    
    func start() {
        navigationController.viewControllers = []
    }
    
    func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.removeAll { $0 === coordinator }
    }
    
    func startFlowCoordinator(_ coordinatorType: Coordinator.Type) {
        
        let coordinator: Coordinator
        coordinator = LoginCoordinator(navigationController: navigationController, diContainer: diContainer)
        
        addChildCoordinator(coordinator)
        coordinator.start()
    }
    
    
}

