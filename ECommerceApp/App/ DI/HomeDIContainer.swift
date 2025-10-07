//
//  HomeDIContainer.swift
//  ECommerceApp
//
//  Created by mac on 06/10/2025.
//

import Foundation

class HomeDIContainer {
    
    static let shared = HomeDIContainer()
    private init() {}
    
    // MARK: - GetViewModel
    
    func getHomeViewModel(coordinator: HomeCoordinator) -> HomeViewModel {
        return HomeViewModel(coordinator: coordinator)
    }
}
