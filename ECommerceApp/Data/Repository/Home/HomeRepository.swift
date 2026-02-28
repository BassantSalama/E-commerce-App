//
//  HomeRepository.swift
//  ECommerceApp
//
//  Created by mac on 06/10/2025.
//

import Combine
import Foundation

protocol HomeRepositoryProtocol {
    func fetchProducts(handle: String, first: Int, after cursor: String?) -> AnyPublisher<ProductsResponse, APIError>
    func fetchBanners(handle: String, first: Int) -> AnyPublisher<[Banner], APIError>
}

final class HomeRepository: HomeRepositoryProtocol {
    
    private let network: NetworkService
    
    init(network: NetworkService = NetworkManager.shared) {
        self.network = network
    }
    
    func fetchProducts(handle: String, first: Int, after cursor: String?) -> AnyPublisher<ProductsResponse, APIError> {
        let endpoint = HomeEndpoint.getCollection(handle: handle, first: first, after: cursor)
        
        return Future<ProductsResponse, APIError> { [weak self] promise in
            self?.network.request(endpoint.request) { (result: Result<CollectionResponse, APIError>) in
                switch result {
                case .success(let response):
                    let products = response.collectionByHandle.products.edges.map { $0.node }
                    
                    let pageInfo = response.collectionByHandle.products.pageInfo
                    
                    let result = ProductsResponse(products: products, pageInfo: pageInfo)
                    promise(.success(result))
                    
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func fetchBanners(handle: String, first: Int) -> AnyPublisher<[Banner], APIError> {
        let endpoint = HomeEndpoint.getCollection(handle: handle, first: first, after: nil)
        
        return Future<[Banner], APIError> { [weak self] promise in
            self?.network.request(endpoint.request) { (result: Result<CollectionResponse, APIError>) in
                switch result {
                case .success(let response):
                    let banners = response.collectionByHandle.products.edges.map {
                        Banner(id: $0.node.id, imageURL: $0.node.imageURL)
                    }
                    promise(.success(banners))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
