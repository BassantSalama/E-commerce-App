//
//  ForgotPasswordUseCaseProtocol.swift
//  ECommerceApp
//
//  Created by mac on 04/10/2025.
//

import Combine

protocol ForgotPasswordUseCaseProtocol {
    func execute(email: String) -> AnyPublisher<Void, Error>
}
