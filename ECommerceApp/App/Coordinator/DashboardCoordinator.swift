//
//  DashboardCoordinator.swift
//  ECommerceApp
//
//  Created by mac on 23/09/2025.
//

import UIKit

protocol DashboardCoordinatorProtocol: AnyObject {
    func presentErrorAlert(message: String)
}

final class DashboardCoordinator: Coordinator {
    weak var parentCoordinator: AppCoordinator?
    var childCoordinators = [Coordinator]()
    
    let navigationController: UINavigationController
    private let diContainer: DIContainer
    
    init(navigationController: UINavigationController, diContainer: DIContainer) {
        self.navigationController = navigationController
        self.diContainer = diContainer
    }
    
    func start() {
        let tabBarController = UITabBarController()

        let homeVC = UIViewController()
        homeVC.view.backgroundColor = .red
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)

        let ordersVC = UIViewController()
        ordersVC.view.backgroundColor = .blue
        ordersVC.tabBarItem = UITabBarItem(title: "Orders", image: UIImage(systemName: "cart"), tag: 1)

        let favVC = UIViewController()
        favVC.view.backgroundColor = .green
        favVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart"), tag: 2)

        let profileVC = UIViewController()
        profileVC.view.backgroundColor = .yellow
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 3)

        tabBarController.viewControllers = [homeVC, ordersVC, favVC, profileVC]

        navigationController.viewControllers = [tabBarController]
    }

}


/*
 final class DashboardCoordinator: Coordinator {
 weak var parentCoordinator: AppCoordinator?
 var childCoordinators = [Coordinator]()
 
 let navigationController: UINavigationController
 private let diContainer: DIContainer
 
 init(navigationController: UINavigationController, diContainer: DIContainer) {
 self.navigationController = navigationController
 self.diContainer = diContainer
 }
 
 func start() {
 // initial dashboard setup placeholder
 let placeholderVC = UIViewController()
 placeholderVC.view.backgroundColor = .white
 placeholderVC.title = "Dashboard"
 navigationController.viewControllers = [placeholderVC]
 }
 }
 
 extension DashboardCoordinator: DashboardCoordinatorProtocol {
 func presentErrorAlert(message: String) {
 let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
 alertController.addAction(UIAlertAction(title: "OK", style: .default))
 navigationController.present(alertController, animated: true)
 }
 }
 */
