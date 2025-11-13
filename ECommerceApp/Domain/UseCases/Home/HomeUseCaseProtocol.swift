//
//  HomeUseCaseProtocol.swift
//  ECommerceApp
//
//  Created by mac on 06/10/2025.
//

import Combine

protocol HomeUseCaseProtocol {
    func getProducts(first: Int, after cursor: String?) -> AnyPublisher<ProductsResponse, APIError>
    func getBanners(first: Int) -> AnyPublisher<[Banner], APIError>
}
