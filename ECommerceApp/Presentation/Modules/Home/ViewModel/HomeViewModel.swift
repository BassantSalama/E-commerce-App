//
//  HomeViewModel.swift
//  ECommerceApp
//
//  Created by mac on 06/10/2025.
//

import Foundation

class HomeViewModel {
    
    private weak var coordinator: HomeCoordinator?
    
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
    
    func segmentSelected(_ segment: String) {
        switch segment {
        case "Home":
            coordinator?.showHomeScreen()
        case "Category":
            coordinator?.showCategoryScreen()
        default:
            break
        }
    }
    
    let banners = ["banner1", "banner2","banner3", "banner4"]
    let products = [
        Product(name: "The Mirac Jiz", brand: "Lisa Robber", price: 195.0, imageName: "a1"),
        Product(name: "Meriza Kiles", brand: "Gazuna Resika", price: 143.45, imageName: "a2")
    ]
}
