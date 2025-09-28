//
//  LoginDIContainer .swift
//  ECommerceApp
//
//  Created by mac on 24/09/2025.
//

import UIKit

class LoginDIContainer {
    
    static let shared = LoginDIContainer()
    private init() {}
    
    // MARK: - ViewModel
    func getLoginViewModel(coordinator: LoginCoordinator) -> LoginViewModel {
        let useCase = getLoginUseCase()
        return LoginViewModel(coordinator: coordinator, useCase: useCase)
    }
    
    // MARK: - UseCase
    private func getLoginUseCase() -> LoginUseCaseProtocol {
        let repository = getLoginRepository()
        return LoginUseCase(repository: repository)
    }
    
    // MARK: - Repository
    private func getLoginRepository() -> LoginRepositoryProtocol {
        return LoginRepository()
    }
}
