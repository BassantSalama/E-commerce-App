//
//  CategoryViewModel.swift
//  ECommerceApp
//
//  Created by mac on 05/11/2025.
//

import Foundation

class CategoryViewModel {
    
    private weak var coordinator: CategoryCoordinator?
    
    init(coordinator: CategoryCoordinator) {
        self.coordinator = coordinator
    }
    
    func didTapHomeSegment() {
        coordinator?.showHomeScreen()
    }
    
}
