//
//  CategoryUseCaseProtocol.swift
//  ECommerceApp
//
//  Created by mac on 11/11/2025.
//

import Combine
import Foundation

// MARK: - UseCase Protocol
protocol CategoryUseCaseProtocol {
    func getCategories() -> AnyPublisher<[Category], APIError>
}
