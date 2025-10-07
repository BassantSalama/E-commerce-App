//
//  HomeViewController.swift
//  ECommerceApp
//
//  Created by mac on 06/10/2025.
//

import UIKit

class HomeViewController: UIViewController {
    
    var viewModel: HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.tintColor = AppColors.primary
    }
    
}
