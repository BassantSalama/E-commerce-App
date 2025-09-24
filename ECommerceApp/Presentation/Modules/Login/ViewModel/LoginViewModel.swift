//
//  LoginViewModel.swift
//  ECommerceApp
//
//  Created by mac on 24/09/2025.
//

class LoginViewModel {
    
    var onLoginSuccess: (() -> Void)?
    var onLoginFailure: ((String) -> Void)?
    
    private let loginUseCase: LoginUseCaseProtocol
    
    init(loginUseCase: LoginUseCaseProtocol = LoginUseCase()) {
        self.loginUseCase = loginUseCase
    }
    
    func login(email: String, password: String) {
        guard validate(email: email, password: password) else {
            onLoginFailure?("Please enter a valid email and password.")
            return
        }
        
        loginUseCase.execute(email: email, password: password) { [weak self] result in
            switch result {
            case .success:
                self?.onLoginSuccess?()
            case .failure(let error):
                self?.onLoginFailure?(error.localizedDescription)
            }
        }
    }
    
    private func validate(email: String, password: String) -> Bool {
        return !email.isEmpty && email.contains("@") && password.count >= 6
    }
}
