//
//  DIContainer.swift
//  ECommerceApp
//
//  Created by mac on 23/09/2025.
//

class DIContainer {
    
    static let shared = DIContainer()
    private init() {}
    
    func makeLoginDIContainer() -> LoginDIContainer {
        return LoginDIContainer()
    }
}
