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
        
        let userInformation = getUserInformation()
        viewModel.signUp(userInformation)
    }
    
    @IBAction func haveAccountTapped(_ sender: Any) {
        viewModel.didTappedHaveAccount()
    }
}

// MARK: - Private Methods
private extension SignUpViewController {
    
    func configureKeyboardHandling() {
        setupTextFieldNavigation()
        setupKeyboardObservers()
    }
    
    func setupTextFieldNavigation() {
        setupEmailTextField()
        setupPasswordTextField()
        setupConfirmPasswordTextField()
    }
    
    private func setupEmailTextField() {
        emailTextField.enableNextField(nextField: passwordTextField)
    }
    
    private func setupPasswordTextField() {
        passwordTextField.enableNextField(nextField: confirmPasswordTextField)
    }
    
    private func setupConfirmPasswordTextField() {
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
                self?.showAlert(
                    title: SignUpConstants.Alerts.successTitle,
                    message: SignUpConstants.Alerts.successMessage,
                    actionTitle: SignUpConstants.Alerts.continueAction
                )
            }
            .store(in: &cancellables)
    }
    
    func bindSignUpFailure() {
        viewModel.signUpFailure
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                self?.showAlert(
                    title: SignUpConstants.Alerts.errorTitle,
                    message: errorMessage,
                    actionTitle: SignUpConstants.Alerts.okAction
                )
            }
            .store(in: &cancellables)
    }
    
    func getUserInformation() -> SignUpModel {
        return SignUpModel(
            email: emailTextField.text ?? "",
            password: passwordTextField.text ?? "",
            confirmPassword: confirmPasswordTextField.text ?? ""
        )
    }
}
