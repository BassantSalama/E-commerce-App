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
        let useCase = getCategoryUseCase()
        return CategoryViewModel(coordinator: coordinator, useCase: useCase)
    }
    
    // MARK: - UseCase
    func getCategoryUseCase() -> CategoryUseCaseProtocol {
        CategoryUseCase(repository: getCategoryRepository())
    }
    
    // MARK: - Repository
    func getCategoryRepository() ->CategoryRepositoryProtocol {
        CategoryRepository(network: NetworkManager.shared)
    }
}
