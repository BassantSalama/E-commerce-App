//
//  CategoryCoordinator.swift
//  ECommerceApp
//
//  Created by mac on 05/11/2025.
//

import Foundation
import UIKit

class CategoryCoordinator : Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: Coordinator?
    
    init(navigationController: UINavigationController, parentCoordinator: Coordinator? = nil) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    func start() {
        parentCoordinator?.addChildCoordinator(self)
        
        guard let CategoryVC = makeCategoryViewController() else { return }
        navigationController.pushViewController(CategoryVC, animated: true)
    }
    
    
    private func makeCategoryViewController() -> CategoryViewController? {
        let storyBoard = UIStoryboard(name:CategoryConstants.StoryboardConstants.name, bundle: nil)
        guard let CategoryVC = storyBoard.instantiateViewController(
            withIdentifier: CategoryConstants.StoryboardConstants.viewControllerID
        ) as? CategoryViewController else  { return nil }
        
        CategoryVC.viewModel = CategoryDIContainer.shared.getCategoryViewModel(coordinator: self)
        
        return CategoryVC
    }
    
    func showHomeScreen() {
        let homeCoordinator = HomeCoordinator(navigationController: navigationController, parentCoordinator: parentCoordinator)
        homeCoordinator.start()
    }
}

