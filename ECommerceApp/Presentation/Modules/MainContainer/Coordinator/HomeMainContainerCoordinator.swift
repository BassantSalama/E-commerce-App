//
//  HomeMainContainerCoordinator.swift
//  ECommerceApp
//
//  Created by mac on 14/11/2025.
//

import UIKit

class HomeMainContainerCoordinator : Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: Coordinator?
    
    init(navigationController: UINavigationController, parentCoordinator: Coordinator? = nil) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    func start() {
        parentCoordinator?.addChildCoordinator(self)
        
        guard let HomeMainContainerVC = makeHomeMainContainerVC() else { return }
        navigationController.pushViewController(HomeMainContainerVC, animated: false)
        
    }
    
    func makeHomeMainContainerVC() -> HomeMainContainerViewController? {
        let storyBoard = UIStoryboard(
            name: HomeMainContainerConstants.Storyboard.name,
            bundle: nil
        )
        
        guard let homeMainContainerVC = storyBoard.instantiateViewController(
            withIdentifier: HomeMainContainerConstants.Storyboard.viewControllerID
        ) as? HomeMainContainerViewController else { return nil }
        
        return homeMainContainerVC
    }
    
}
