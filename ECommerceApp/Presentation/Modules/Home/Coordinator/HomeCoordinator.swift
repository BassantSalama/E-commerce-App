//
//  HomeCoordinator.swift
//  ECommerceApp
//
//  Created by mac on 06/10/2025.
//

import UIKit

class HomeCoordinator : Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: Coordinator?
    
    init(navigationController: UINavigationController, parentCoordinator: Coordinator? = nil) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    func start() {
        parentCoordinator?.addChildCoordinator(self)
        
        guard let homeVC = makeHomeViewController() else { return }
        navigationController.pushViewController(homeVC, animated: false)
        
    }
    
    private func makeHomeViewController() -> HomeViewController? {
        let storyBoard = UIStoryboard(name: HomeConstants.StoryboardConstants.name, bundle: nil)
        guard let homeVC = storyBoard.instantiateViewController(
            withIdentifier: HomeConstants.StoryboardConstants.viewControllerID
        ) as? HomeViewController else  { return nil }
        
        homeVC.viewModel = HomeDIContainer.shared.getHomeViewModel(coordinator: self)
        
        return homeVC
    }
}
