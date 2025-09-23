//
//  AppCoordinator.swift
//  ECommerceApp
//
//  Created by mac on 23/09/2025.
//

import UIKit

final class AppCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    private let window: UIWindow
    private let diContainer: DIContainer
    
    init(window: UIWindow, diContainer: DIContainer) {
        self.window = window
        self.diContainer = diContainer
    }
    
    func start() {
        showDashboard()
    }
    
    private func showDashboard() {
        let dashboardCoordinator = DashboardCoordinator(navigationController: UINavigationController(), diContainer: diContainer)
        dashboardCoordinator.parentCoordinator = self
        childCoordinators.append(dashboardCoordinator)
        dashboardCoordinator.start()
        
        window.rootViewController = dashboardCoordinator.navigationController
        window.makeKeyAndVisible()
    }
}
