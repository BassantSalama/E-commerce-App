//
//  LoginViewModel.swift
//  ECommerceApp
//
//  Created by mac on 24/09/2025.
//

import Combine

class LoginViewModel {
    // MARK: - Output
    let loginSuccess = PassthroughSubject<Void, Never>()
    let loginFailure = PassthroughSubject<String, Never>()
    
    // MARK: - Dependencies
    private let loginUseCase: LoginUseCaseProtocol
    private weak var coordinator: LoginCoordinator?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init(coordinator: LoginCoordinator? = nil, useCase: LoginUseCaseProtocol = LoginUseCase()) {
        self.coordinator = coordinator
        self.loginUseCase = useCase
    }
    
    // MARK: - Login
    func login(email: String, password: String) {
        do {
            
            try Validator.validate(email: email, password: password)
            
            loginUseCase.execute(email: email, password: password)
                .sink { [weak self] completion in
                    
                    switch completion {
                    case .failure(let error):
                        self?.loginFailure.send(error.localizedDescription)
                    case .finished:
                        break
                    }
                } receiveValue: { [weak self] in
                    
                    self?.loginSuccess.send(())
                }
                .store(in: &cancellables)
            
        } catch {
            
            loginFailure.send(error.localizedDescription)
        }
    }
}
