//
//  LoginViewController.swift
//  ECommerceApp
//
//  Created by mac on 22/09/2025.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginScrollView: UIScrollView!
    @IBOutlet weak var emailTextField: EmailTextField!
    @IBOutlet weak var passwordTextField: PasswordTextField!
    
    var viewModel: LoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureKeyboardHandling()
    }
    
    private func setupTextFieldNavigation() {
        emailTextField.enableNextField(nextField: passwordTextField)
        passwordTextField.enableNextField(nextField: nil)
    }
    
    private func setupKeyboardObservers() {
        observeKeyboard(for: loginScrollView)
    }
    
    private func configureKeyboardHandling() {
        setupTextFieldNavigation()
        setupKeyboardObservers()
    }
    
    deinit {
        removeKeyboardObservers()
    }
    
}
