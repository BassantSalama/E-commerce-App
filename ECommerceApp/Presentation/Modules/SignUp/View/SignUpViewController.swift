//
//  SignUpViewController.swift
//  ECommerceApp
//
//  Created by mac on 29/09/2025.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var signUpScrollView: UIScrollView!
    @IBOutlet weak var emailTextField: EmailTextField!
    @IBOutlet weak var passwordTextField: PasswordTextField!
    @IBOutlet weak var confirmPasswordTextField: PasswordTextField!
    
    var viewModel: SignUpViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureKeyboardHandling()
    }
    
}

// MARK: - Private Methods
private extension SignUpViewController {
    
    func configureKeyboardHandling() {
        setupTextFieldNavigation()
        setupKeyboardObservers()
    }
    
    func setupTextFieldNavigation() {
        emailTextField.enableNextField(nextField: passwordTextField)
        passwordTextField.enableNextField(nextField: confirmPasswordTextField)
        confirmPasswordTextField.enableNextField(nextField: nil)
    }
    
    func setupKeyboardObservers() {
        observeKeyboard(for: signUpScrollView)
    }
}
