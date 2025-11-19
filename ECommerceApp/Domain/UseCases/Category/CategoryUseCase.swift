//
//  CategoryUseCase.swift
//  ECommerceApp
//
//  Created by mac on 11/11/2025.
//

import Combine
import Foundation

// MARK: - UseCase Implementation
final class CategoryUseCase: CategoryUseCaseProtocol {
    
    private let repository: CategoryRepositoryProtocol
    
    init(repository: CategoryRepositoryProtocol) {
        self.repository = repository
    }
    
    func getCategories() -> AnyPublisher<[Category], APIError> {
        repository.fetchCategories()
    }
}
