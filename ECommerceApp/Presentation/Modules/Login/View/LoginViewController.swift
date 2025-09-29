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
    
    @IBAction func logInInButtonTapped(_ sender: Any) {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        viewModel.login(email: email, password: password)
    }
    
    
    @IBAction func doNotHaveAccountTapped(_ sender: Any) {
        viewModel.navigateToSignUp()
    }
    
}

// MARK: - Private Methods
private extension LoginViewController {
    
    func configureKeyboardHandling() {
        setupTextFieldNavigation()
        setupKeyboardObservers()
    }
    
    func setupTextFieldNavigation() {
        emailTextField.enableNextField(nextField: passwordTextField)
        passwordTextField.enableNextField(nextField: nil)
    }
    
    func setupKeyboardObservers() {
        observeKeyboard(for: loginScrollView)
    }
    
    func setupBindings() {
        bindLoginSuccess()
        bindLoginFailure()
    }
    
    func bindLoginSuccess() {
        viewModel.loginSuccess
            .receive(on: DispatchQueue.main)
            .sink {
                print("Login Success")
            }
            .store(in: &cancellables)
    }
    
    func bindLoginFailure() {
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
