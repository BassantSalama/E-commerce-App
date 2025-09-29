//
//  SignUpViewController.swift
//  ECommerceApp
//
//  Created by mac on 29/09/2025.
//

import UIKit
import Combine

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var signUpScrollView: UIScrollView!
    @IBOutlet weak var emailTextField: EmailTextField!
    @IBOutlet weak var passwordTextField: PasswordTextField!
    @IBOutlet weak var confirmPasswordTextField: PasswordTextField!
    
    var viewModel: SignUpViewModel!
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureKeyboardHandling()
        bindViewModel()
        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.tintColor = AppColors.primary
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let confirmPassword = confirmPasswordTextField.text ?? ""
        
        viewModel.signUp(email: email, password: password, confirmPassword: confirmPassword)
    }
    
    @IBAction func haveAccountTapped(_ sender: Any) {
        viewModel.navigateToLogin()
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
    
    func bindViewModel() {
        bindSignUpSuccess()
        bindSignUpFailure()
    }
    
    func bindSignUpSuccess() {
        viewModel.signUpSuccess
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.showAlert(title: "Success", message: "Account created successfully!")
            }
            .store(in: &cancellables)
    }
    
    func bindSignUpFailure() {
        viewModel.signUpFailure
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                self?.showAlert(title: "Error", message: errorMessage)
            }
            .store(in: &cancellables)
    }
    
    
    func showAlert(title: String, message: String) {
        DispatchQueue.main.async {
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true)
            }
    }
}
