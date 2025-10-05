//
//  ForgotPasswordRepository.swift
//  ECommerceApp
//
//  Created by mac on 04/10/2025.
//

import FirebaseAuth
import Combine

// MARK: - Protocol
protocol ForgotPasswordRepositoryProtocol {
    func sendResetLink(email: String) -> AnyPublisher<Void, Error>
}

// MARK: - Implementation
class ForgotPasswordRepository: ForgotPasswordRepositoryProtocol {
    func sendResetLink(email: String) -> AnyPublisher<Void, Error> {
        Future<Void, Error> { promise in
            Auth.auth().sendPasswordReset(withEmail: email) { error in
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

