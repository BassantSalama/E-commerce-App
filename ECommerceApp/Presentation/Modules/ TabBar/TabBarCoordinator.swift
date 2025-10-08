//
//  TabBarCoordinator.swift
//  ECommerceApp
//
//  Created by mac on 08/10/2025.
//

import UIKit
import Combine

final class TabBarCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var logoutPublisher = PassthroughSubject<Void, Never>()
    weak var parentCoordinator: Coordinator?
    var tabBarController: MainTabBarController?
    
    init(navigationController: UINavigationController, parentCoordinator: Coordinator? = nil) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    func start() {
        let tabBarController = MainTabBarController()
        self.tabBarController = tabBarController
        parentCoordinator?.addChildCoordinator(self)
        
        setupTabs()
        navigationController.setViewControllers([tabBarController], animated: true)
    }
    
    private func setupTabs() {
        tabBarController?.viewControllers = [
            createHomeFlow(),
            createFavoritesFlow(),
            createOrdersFlow(),
            createProfileFlow()
        ]
    }
    
    private func createHomeFlow() -> UINavigationController {
        let homeNavigationController = UINavigationController()
        let homeCoordinator = HomeCoordinator(navigationController: homeNavigationController,parentCoordinator: self)
        homeCoordinator.start()
        
        homeNavigationController.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            tag: 0
        )
        
        return homeNavigationController
    }
    
    private func createFavoritesFlow() -> UINavigationController {
        let favoritesViewController = UIViewController()
        favoritesViewController.view.backgroundColor = .systemBackground
        favoritesViewController.title = "Favorites"
        
        let favoritesNavigationController = UINavigationController(rootViewController: favoritesViewController)
        favoritesNavigationController.tabBarItem = UITabBarItem(
            title: "Favorites",
            image: UIImage(systemName: "heart"),
            tag: 1
        )
        
        return favoritesNavigationController
    }
    
    private func createOrdersFlow() -> UINavigationController {
        let ordersViewController = UIViewController()
        ordersViewController.view.backgroundColor = .systemBackground
        ordersViewController.title = "My Orders"
        
        let ordersNavigationController = UINavigationController(rootViewController: ordersViewController)
        ordersNavigationController.tabBarItem = UITabBarItem(
            title: "My Orders",
            image: UIImage(systemName: "cart"),
            tag: 2
        )
        
        return ordersNavigationController
    }
    
    private func createProfileFlow() -> UINavigationController {
        let profileViewController = UIViewController()
        profileViewController.view.backgroundColor = .systemBackground
        profileViewController.title = "Profile"
        
        let profileNavigationController = UINavigationController(rootViewController: profileViewController)
        profileNavigationController.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person"),
            tag: 3
        )
        
        return profileNavigationController
    }
}
