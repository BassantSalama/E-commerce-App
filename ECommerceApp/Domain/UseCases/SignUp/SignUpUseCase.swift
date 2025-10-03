//
//  SignUpUseCase.swift
//  ECommerceApp
//
//  Created by mac on 29/09/2025.
//
import Combine

class SignUpUseCase: SignUpUseCaseProtocol {
    private let repository: SignUpRepositoryProtocol
    
    init(repository: SignUpRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(email: String, password: String) -> AnyPublisher<Void, Error> {
        return repository.signUp(email: email, password: password)
    }
}
