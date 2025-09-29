//
//  LoginUseCaseProtocol.swift
//  ECommerceApp
//
//  Created by mac on 24/09/2025.
//

import Combine

protocol LoginUseCaseProtocol {
    func execute(email: String, password: String) -> AnyPublisher<Void, Error>
}
