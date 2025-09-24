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
        setupBindings()
    }
    
    private func configureKeyboardHandling() {
        emailTextField.enableNextField(nextField: passwordTextField)
        passwordTextField.enableNextField(nextField: nil)
        observeKeyboard(for: loginScrollView)
    }
    
    @IBAction func logInInButtonTapped(_ sender: Any) {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        viewModel.login(email: email, password: password)
    }
    
    private func setupBindings() {
        viewModel.onLoginSuccess = {
            DispatchQueue.main.async {
                print("Login Success")
            }
        }
        viewModel.onLoginFailure = { [weak self] error in
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Login Error", message: error, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(alert, animated: true)
            }
        }
    }
    
    deinit {
        removeKeyboardObservers()
    }
    
}
