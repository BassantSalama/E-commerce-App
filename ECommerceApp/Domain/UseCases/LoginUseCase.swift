//
//  LoginUseCase.swift
//  ECommerceApp
//
//  Created by mac on 24/09/2025.
//

import Combine

class LoginUseCase: LoginUseCaseProtocol {
    private let repository: LoginRepositoryProtocol
    
    init(repository: LoginRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(email: String, password: String) -> AnyPublisher<Void, Error> {
        repository.login(email: email, password: password)
    }
}
