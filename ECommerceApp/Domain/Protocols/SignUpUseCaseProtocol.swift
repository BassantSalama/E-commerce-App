//
//  SignUpUseCaseProtocol.swift
//  ECommerceApp
//
//  Created by mac on 29/09/2025.
//

import Combine

protocol SignUpUseCaseProtocol {
    func execute(email: String, password: String) -> AnyPublisher<Void, Error>
}
