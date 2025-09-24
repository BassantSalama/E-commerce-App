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
        startFlowCoordinator(LoginCoordinator.self)
    }
    
    func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.removeAll { $0 === coordinator }
    }
    
    func startFlowCoordinator(_ coordinatorType: Coordinator.Type) {
        let coordinator: Coordinator
        
        switch coordinatorType {
        case is LoginCoordinator.Type:
            let loginDIContainer = diContainer.makeLoginDIContainer()
            coordinator = LoginCoordinator(
                navigationController: navigationController,
                diContainer: loginDIContainer
            )
            
        default:
            print(" Unsupported coordinator type: \(coordinatorType)")
            return
        }
        
        addChildCoordinator(coordinator)
        coordinator.start()
    }
}

