//
//  LoginViewController.swift
//  ECommerceApp
//
//  Created by mac on 22/09/2025.
//

import UIKit
import Combine

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginScrollView: UIScrollView!
    @IBOutlet weak var emailTextField: EmailTextField!
    @IBOutlet weak var passwordTextField: PasswordTextField!
    
    var viewModel: LoginViewModel!
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureKeyboardHandling()
        setupBindings()
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
    
    @IBAction func logInInButtonTapped(_ sender: Any) {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        viewModel.login(email: email, password: password)
    }
    
    private func setupBindings() {
        bindLoginSuccess()
        bindLoginFailure()
    }
    
    private func bindLoginSuccess() {
        viewModel.loginSuccess
            .receive(on: DispatchQueue.main)
            .sink { 
                print("Login Success")
            }
            .store(in: &cancellables)
    }
    
    private func bindLoginFailure() {
        viewModel.loginFailure
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                let alert = UIAlertController(title: "Login Error", message: error, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(alert, animated: true)
            }
            .store(in: &cancellables)
    }
}
