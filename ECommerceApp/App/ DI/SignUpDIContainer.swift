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
    
    func getSignUpViewModel(coordinator: SignUpCoordinator) -> SignUpViewModel {
        return SignUpViewModel(coordinator: coordinator)
    }
}
