//
//  HomeUseCases.swift
//  ECommerceApp
//
//  Created by mac on 06/10/2025.
//

import Foundation
import Combine

final class HomeUseCase: HomeUseCaseProtocol {
    
    private let repository: HomeRepositoryProtocol
    
    init(repository: HomeRepositoryProtocol) {
        self.repository = repository
    }
    
    func getProducts(first: Int, after cursor: String?) -> AnyPublisher<ProductsResponse, APIError> {
        repository.fetchProducts(handle: "newarrivals", first: first, after: cursor)
    }
    
    func getBanners(first: Int) -> AnyPublisher<[Banner], APIError> {
        repository.fetchBanners(handle: "bannersection", first: first)
    }
}
