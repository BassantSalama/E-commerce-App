//
//  HomeCoordinator.swift
//  ECommerceApp
//
//  Created by mac on 06/10/2025.
//

import UIKit

class HomeCoordinator  {
    
    func makeHomeViewController() -> HomeViewController? {
        let storyBoard = UIStoryboard(name: HomeConstants.StoryboardConstants.name, bundle: nil)
        guard let homeVC = storyBoard.instantiateViewController(
            withIdentifier: HomeConstants.StoryboardConstants.viewControllerID
        ) as? HomeViewController else  { return nil }
        
        homeVC.viewModel = HomeDIContainer.shared.getHomeViewModel(coordinator: self)
        
        return homeVC
    }
}

