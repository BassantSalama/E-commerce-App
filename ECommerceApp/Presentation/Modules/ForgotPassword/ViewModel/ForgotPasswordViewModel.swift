//
//  ForgotPasswordViewModel.swift
//  ECommerceApp
//
//  Created by mac on 04/10/2025.
//
import Foundation
import Combine

class ForgotPasswordViewModel {
    
    // MARK: - Dependencies
    private weak var coordinator: ForgotPasswordCoordinator?
    private let useCase: ForgotPasswordUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Observers
    let resetSuccess = PassthroughSubject<Void, Never>()
    let resetFailure = PassthroughSubject<String, Never>()
    
    // MARK: - Init
    init(coordinator: ForgotPasswordCoordinator, useCase: ForgotPasswordUseCaseProtocol) {
        self.coordinator = coordinator
        self.useCase = useCase
    }
    
    // MARK: - Send Reset Link
    func sendResetLink(_ model: ForgotPasswordModel) {
        guard validateInput(model) else {
            resetFailure.send(ForgotPasswordConstants.AlertMessages.invalidEmail)
            return
        }
        useCase.execute(email: model.email)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    self?.resetSuccess.send(())
                case .failure(let error):
                    self?.resetFailure.send(error.localizedDescription)
                }
            } receiveValue: { _ in }
            .store(in: &cancellables)
    }
    
    // MARK: - Validate Input
    private func validateInput(_ model: ForgotPasswordModel) -> Bool {
        return ForgotPasswordValidator.validateEmail(model.email)
    }
    
    // MARK: - Navigation
    func didTappedBackToLogin() {
        coordinator?.navigateToLogin()
    }
}
