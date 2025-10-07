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
        let userInformation = getUserInformation()
        viewModel.login(userInformation)
    }
    
    @IBAction func doNotHaveAccountTapped(_ sender: Any) {
        viewModel.didTapDoNotHaveAccount()
    }
    
    @IBAction func forgotPasswordTapped(_ sender: Any) {
        viewModel.didTapForgotPassword()
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
                self.viewModel.didLoginSuccessfully()
            }
            .store(in: &cancellables)
    }
    
    func bindLoginFailure() {
        viewModel.loginFailure
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                self?.showAlert(
                    title: LoginConstants.Alerts.errorTitle,
                    message: error,
                    actionTitle: LoginConstants.Alerts.okAction
                )
            }
            .store(in: &cancellables)
    }
    
    func getUserInformation() -> LoginModel {
        return LoginModel(
            email: emailTextField.text ?? "",
            password: passwordTextField.text ?? ""
        )
    }
}
