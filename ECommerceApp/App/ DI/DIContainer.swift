//
//  DIContainer.swift
//  ECommerceApp
//
//  Created by mac on 23/09/2025.
//

import UIKit

final class DIContainer {
    
    func makeDashboardCoordinator(navigationController: UINavigationController) -> DashboardCoordinator {
        return DashboardCoordinator(navigationController: navigationController, diContainer: self)
    }
}
