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
}
