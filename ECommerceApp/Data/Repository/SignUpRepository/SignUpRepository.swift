//
//  SignUpRepository.swift
//  ECommerceApp
//
//  Created by mac on 29/09/2025.
//

import Combine
import FirebaseAuth

// MARK: - Protocol
protocol SignUpRepositoryProtocol {
    func signUp(email: String, password: String) -> AnyPublisher<Void, Error>
}

// MARK: - Implementation
class SignUpRepository: SignUpRepositoryProtocol {
    func signUp(email: String, password: String) -> AnyPublisher<Void, Error> {
        Future { promise in
            Auth.auth().createUser(withEmail: email, password: password) { _, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(()))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
