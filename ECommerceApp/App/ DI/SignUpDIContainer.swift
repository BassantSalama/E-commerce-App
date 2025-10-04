//
//  SignupCoordinator.swift
//  ECommerceApp
//
//  Created by mac on 29/09/2025.
//

import Foundation

// MARK: - SignUpDIContainer
class SignUpDIContainer {
    
    static let shared = SignUpDIContainer()
    private init() {}
    
    // MARK: - ViewModel
    func getSignUpViewModel(coordinator: SignUpCoordinator) -> SignUpViewModel {
        let useCase = getSignUpUseCase()
        return SignUpViewModel(coordinator: coordinator, useCase: useCase)
    }
    
    // MARK: - UseCase
    private func getSignUpUseCase() -> SignUpUseCaseProtocol {
        let repository = getSignUpRepository()
        return SignUpUseCase(repository: repository)
    }
    
    // MARK: - Repository
    private func getSignUpRepository() -> SignUpRepositoryProtocol {
        return SignUpRepository()
    }
}
