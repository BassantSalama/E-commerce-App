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
        return ForgotPasswordViewModel(coordinator: coordinator)
    }
    
  
}
