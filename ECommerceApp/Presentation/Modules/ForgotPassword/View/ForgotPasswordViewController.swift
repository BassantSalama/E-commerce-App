//
//  ForgotPasswordViewController.swift
//  ECommerceApp
//
//  Created by mac on 04/10/2025.
//

import UIKit
import Combine

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var forgotPasswordScrollView: UIScrollView!
    @IBOutlet weak var emailTextField: EmailTextField!
    
    var viewModel: ForgotPasswordViewModel!
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        setupKeyboardObservers()
        bindViewModel()
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.tintColor = AppColors.primary
    }
    
    @IBAction func backToLoginTapped(_ sender: Any) {
        viewModel.didTappedBacktoLogin()
    }
    
    @IBAction func sendResetLLinkTapped(_ sender: Any) {
        let resetEmail = getResetEmail()
        viewModel.sendResetLink(resetEmail)
    }
    
}

// MARK: - Private Methods
private extension ForgotPasswordViewController {
    
    func setupKeyboardObservers() {
        observeKeyboard(for: forgotPasswordScrollView)
    }
    
    func bindViewModel() {
        bindResetSuccess()
        bindResetFailure()
    }
    
    func bindResetSuccess() {
        viewModel.resetSuccess
            .sink { [weak self] in
                self?.showAlert(
                    title: ForgotPasswordConstants.AlertMessages.successTitle,
                    message: ForgotPasswordConstants.AlertMessages.successMessage,
                    actionTitle: ForgotPasswordConstants.AlertMessages.okAction
                )
            }
            .store(in: &cancellables)
    }
    
    func bindResetFailure() {
        viewModel.resetFailure
            .sink { [weak self] message in
                self?.showAlert(
                    title: ForgotPasswordConstants.AlertMessages.errorTitle,
                    message: message,
                    actionTitle: ForgotPasswordConstants.AlertMessages.okAction
                )
            }
            .store(in: &cancellables)
    }
    
    func getResetEmail() -> ForgotPasswordModel {
        return ForgotPasswordModel(email: emailTextField.text ?? "")
    }
}
