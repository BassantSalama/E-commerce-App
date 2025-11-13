//
//  CategoryDIContainer.swift
//  ECommerceApp
//
//  Created by mac on 05/11/2025.
//

import Foundation

class CategoryDIContainer {
    
    static let shared = CategoryDIContainer()
    private init() {}
    
    // MARK: - GetViewModel
    
    func getCategoryViewModel(coordinator: CategoryCoordinator) -> CategoryViewModel{
        return CategoryViewModel(coordinator: coordinator)
    }
}
