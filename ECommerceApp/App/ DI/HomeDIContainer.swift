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
    
    // MARK: - Repository
    func getHomeRepository() -> HomeRepositoryProtocol {
        HomeRepository(network: NetworkManager.shared)
    }
    
    // MARK: - UseCase
    func getHomeUseCase() -> HomeUseCaseProtocol {
        HomeUseCase(repository: getHomeRepository())
    }
    
    // MARK: - ViewModel
    func getHomeViewModel(coordinator: HomeCoordinator) -> HomeViewModel {
        let useCase = getHomeUseCase()
        return HomeViewModel(coordinator: coordinator, useCase: useCase)
    }
}
