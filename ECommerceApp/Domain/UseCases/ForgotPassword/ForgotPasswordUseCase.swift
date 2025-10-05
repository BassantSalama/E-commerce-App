//
//  ForgotPasswordUseCase.swift
//  ECommerceApp
//
//  Created by mac on 04/10/2025.
//

import Combine
import Foundation

class ForgotPasswordUseCase: ForgotPasswordUseCaseProtocol {
    
    private let repository: ForgotPasswordRepositoryProtocol
    
    // MARK: - Init
    init(repository: ForgotPasswordRepositoryProtocol) {
        self.repository = repository
    }
    
    // MARK: - Execute
    func execute(email: String) -> AnyPublisher<Void, Error> {
        return repository.sendResetLink(email: email)
    }
    
}

