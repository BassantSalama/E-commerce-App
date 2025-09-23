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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureKeyboardHandling()
    }
    
    private func configureKeyboardHandling() {
        emailTextField.enableNextField(nextField: passwordTextField)
        passwordTextField.enableNextField(nextField: nil)
        observeKeyboard(for: loginScrollView)
    }
    
    deinit {
        removeKeyboardObservers()
    }
    
}
