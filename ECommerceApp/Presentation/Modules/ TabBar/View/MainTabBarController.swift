//
//  MainTabBarControllerViewController.swift
//  ECommerceApp
//
//  Created by mac on 08/10/2025.
//
import UIKit

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
    }
    private func configureAppearance() {
        tabBar.tintColor = AppColors.primary
        tabBar.unselectedItemTintColor = AppColors.secondary
        tabBar.backgroundColor = .systemBackground
    }
    
}
