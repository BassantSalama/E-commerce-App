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
    
    func getLoginViewModel(coordinator: LoginCoordinator) -> LoginViewModel {
        return LoginViewModel(coordinator: coordinator)
    }
}
