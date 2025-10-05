//
//  LoginRepository.swift
//  ECommerceApp
//
//  Created by mac on 28/09/2025.
//

import Combine
import FirebaseAuth
import FirebaseFirestore

// MARK: - Protocol
protocol LoginRepositoryProtocol {
    func login(email: String, password: String) -> AnyPublisher<Void, Error>
}

// MARK: - Implementation
class LoginRepository: LoginRepositoryProtocol {
    
    func login(email: String, password: String) -> AnyPublisher<Void, Error> {
        Future { promise in
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    promise(.failure(error))
                    return
                }
                
                guard let user = authResult?.user else {
                    promise(.failure(NSError(
                        domain: "LoginError",
                        code: -1,
                        userInfo: [NSLocalizedDescriptionKey: "User not found"]
                    )))
                    return
                }
                
                let db = Firestore.firestore()
                let userRef = db.collection("users").document(user.uid)
                
                userRef.getDocument { document, _ in
                    if let document = document, document.exists {
                        promise(.success(()))
                    } else {
                        let userData: [String: Any] = [
                            "id": user.uid,
                            "email": user.email ?? "",
                            "name": user.email?.components(separatedBy: "@").first ?? "Unknown"
                        ]
                        userRef.setData(userData) { error in
                            if let error = error {
                                promise(.failure(error))
                            } else {
                                promise(.success(()))
                            }
                        }
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
