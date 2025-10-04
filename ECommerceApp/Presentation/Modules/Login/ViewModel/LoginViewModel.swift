//
//  LoginViewModel.swift
//  ECommerceApp
//
//  Created by mac on 24/09/2025.
//

import Combine

class LoginViewModel {
    // MARK: - Observers
    let loginSuccess = PassthroughSubject<Void, Never>()
    let loginFailure = PassthroughSubject<String, Never>()
    
    // MARK: - Dependencies
    private let loginUseCase: LoginUseCaseProtocol
    private weak var coordinator: LoginCoordinator?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init(coordinator: LoginCoordinator? = nil,
         useCase: LoginUseCaseProtocol) {
        self.coordinator = coordinator
        self.loginUseCase = useCase
    }
    
    // MARK: - Login
    func login(_ input: LoginModel) {
        do {
            try validateInput(input)
            executeLogin(email: input.email, password: input.password)
        } catch {
            loginFailure.send(error.localizedDescription)
        }
    }
    
    
    // MARK: - Input Validation
    private func validateInput(_ input: LoginModel) throws {
        try LoginValidator.validate(email: input.email, password: input.password)
    }
    
    // MARK: - Use Case Execution
    private func executeLogin(email: String, password: String) {
        loginUseCase.execute(email: email, password: password)
            .sink { [weak self] completion in
                self?.handleCompletion(completion)
            } receiveValue: { [weak self] in
                self?.loginSuccess.send(())
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Handle Completion
    private func handleCompletion(_ completion: Subscribers.Completion<Error>) {
        switch completion {
        case .failure(let error):
            loginFailure.send(error.localizedDescription)
        case .finished:
            break
        }
    }
    // MARK: - Navigation
    func didTapDoNotHaveAccount() {
        coordinator?.navigateToSignUp()
    }
    
    func didTapForgotPassword(){
        coordinator?.navigateToForgotPassword()
    }
}

