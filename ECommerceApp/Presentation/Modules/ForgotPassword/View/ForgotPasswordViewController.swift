//
//  ForgotPasswordViewController.swift
//  ECommerceApp
//
//  Created by mac on 04/10/2025.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    var viewModel: ForgotPasswordViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.tintColor = AppColors.primary
    }
    
    
}
