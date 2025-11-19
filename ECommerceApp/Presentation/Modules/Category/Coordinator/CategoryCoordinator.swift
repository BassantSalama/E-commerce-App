//
//  CategoryCoordinator.swift
//  ECommerceApp
//
//  Created by mac on 05/11/2025.
//

import UIKit

class CategoryCoordinator  {
    
    func makeCategoryViewController() -> CategoryViewController? {
        let storyBoard = UIStoryboard(name:CategoryConstants.StoryboardConstants.name, bundle: nil)
        guard let CategoryVC = storyBoard.instantiateViewController(
            withIdentifier: CategoryConstants.StoryboardConstants.viewControllerID
        ) as? CategoryViewController else  { return nil }
        
        CategoryVC.viewModel = CategoryDIContainer.shared.getCategoryViewModel(coordinator: self)
        
        return CategoryVC
    }
}

