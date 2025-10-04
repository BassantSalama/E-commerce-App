//
//  SignupViewModel.swift
//  ECommerceApp
//
//  Created by mac on 29/09/2025.
//
import Foundation
import Combine

class SignUpViewModel {
    // MARK: - Observers
    let signUpSuccess = PassthroughSubject<Void, Never>()
    let signUpFailure = PassthroughSubject<String, Never>()
    
    // MARK: - Dependencies
    private let signUpUseCase: SignUpUseCaseProtocol
    private weak var coordinator: SignUpCoordinator?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init(coordinator: SignUpCoordinator? = nil,
         useCase: SignUpUseCaseProtocol) {
        self.coordinator = coordinator
        self.signUpUseCase = useCase
    }
    
    // MARK: - SignUp
    func signUp(_ input: SignUpModel) {
        do {
            try validateInput(input)
            executeSignUp(email: input.email, password: input.password)
        } catch {
            signUpFailure.send(error.localizedDescription)
        }
    }
    
    // MARK: - Input Validation
    private func validateInput(_ input: SignUpModel) throws {
        guard input.password == input.confirmPassword else {
            throw NSError(
                domain: "",
                code: 0,
                userInfo: [NSLocalizedDescriptionKey: SignUpConstants.Alerts.passwordMismatch]
            )
        }
        try signUpValidator.validate(email: input.email, password: input.password)
    }
    
    // MARK: - Use Case Execution
    private func executeSignUp(email: String, password: String) {
        signUpUseCase.execute(email: email, password: password)
            .sink { [weak self] completion in
                self?.handleCompletion(completion)
            } receiveValue: { [weak self] in
                self?.signUpSuccess.send(())
            }
            .store(in: &cancellables)
    }
    // MARK: - Handle Completion
    private func handleCompletion(_ completion: Subscribers.Completion<Error>) {
        switch completion {
        case .failure(let error):
            signUpFailure.send(error.localizedDescription)
        case .finished:
            break
        }
    }
    // MARK: - Navigation
    func didTappedHaveAccount() {
        coordinator?.navigateToLogin()
    }
}
