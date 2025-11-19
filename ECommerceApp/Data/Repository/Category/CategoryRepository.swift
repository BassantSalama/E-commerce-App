//
//  CategoryRepository.swift
//  ECommerceApp
//
//  Created by mac on 11/11/2025.
//

import Combine
import Foundation

protocol CategoryRepositoryProtocol {
    func fetchCategories() -> AnyPublisher<[Category], APIError>
}

final class CategoryRepository: CategoryRepositoryProtocol {
    
    private let network: NetworkService
    
    init(network: NetworkService = NetworkManager.shared) {
        self.network = network
    }
    
    func fetchCategories() -> AnyPublisher<[Category], APIError> {
        let endpoint = CategoryEndpoint()
        
        return Future<[Category], APIError> { [weak self] promise in
            self?.network.request(endpoint.request) { (result: Result<CategoryCollectionResponse, APIError>) in
                switch result {
                case .success(let response):
                    let products = response.collectionByHandle.products.edges.map { edge in
                        Category(id: edge.node.id, imageURL: edge.node.imageURL)
                    }
                    promise(.success(products))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
