//
//  AppCoordinator.swift
//  ECommerceApp
//
//  Created by mac on 23/09/2025.
//

import UIKit
import Combine

class AppFlowCoordinator: Coordinator {
    
    var window: UIWindow
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var cancellables = Set<AnyCancellable>()
    
    init(window: UIWindow, navigationController: UINavigationController) {
        self.window = window
        self.navigationController = navigationController
    }
    
    func start() {
        showLoginFlow()
    }
    
    private func showLoginFlow() {
        let loginCoordinator = LoginCoordinator(navigationController: navigationController)
        addChildCoordinator(loginCoordinator)
        
        loginCoordinator.loginSuccessPublisher
            .sink { [weak self] in
                self?.removeChildCoordinator(loginCoordinator)
                self?.showMainTabFlow()
            }
            .store(in: &cancellables)
        
        loginCoordinator.start()
        
        window.rootViewController = navigationController
    }
    
    private func showMainTabFlow() {
        let tabBarCoordinator = TabBarCoordinator(navigationController: navigationController, parentCoordinator: self)
        addChildCoordinator(tabBarCoordinator)
        
        tabBarCoordinator.logoutPublisher
            .sink { [weak self] in
                self?.removeChildCoordinator(tabBarCoordinator)
                self?.showLoginFlow()
            }
            .store(in: &cancellables)
        
        tabBarCoordinator.start()
        
        window.rootViewController = tabBarCoordinator.tabBarController
    }
    
}
