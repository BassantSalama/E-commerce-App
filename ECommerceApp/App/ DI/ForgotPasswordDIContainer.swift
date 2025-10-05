//
//  ForgotPasswordDIContainer.swift
//  ECommerceApp
//
//  Created by mac on 04/10/2025.
//
import UIKit

class ForgotPasswordDIContainer {
    
    static let shared = ForgotPasswordDIContainer()
    private init() {}
    
    // MARK: - ViewModel
    func getForgotPasswordViewModel(coordinator: ForgotPasswordCoordinator) -> ForgotPasswordViewModel {
        let useCase = getForgotPasswordUseCase()
        return ForgotPasswordViewModel(coordinator: coordinator, useCase: useCase)
    }
    
    // MARK: - UseCase
    private func getForgotPasswordUseCase() -> ForgotPasswordUseCaseProtocol {
        let repository = getForgotPasswordRepository()
        return ForgotPasswordUseCase(repository: repository)
    }
    
    // MARK: - Repository
    private func getForgotPasswordRepository() -> ForgotPasswordRepositoryProtocol {
        return ForgotPasswordRepository()
    }
}

