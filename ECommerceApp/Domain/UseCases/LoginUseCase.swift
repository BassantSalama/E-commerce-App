//
//  LoginUseCase.swift
//  ECommerceApp
//
//  Created by mac on 24/09/2025.
//

import FirebaseAuth
import FirebaseFirestore

class LoginUseCase: LoginUseCaseProtocol {
    func execute(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else if let user = authResult?.user {
                let db = Firestore.firestore()
                let userRef = db.collection("users").document(user.uid)
                
                userRef.getDocument { document, error in
                    if let document = document, document.exists {
                        
                        completion(.success(()))
                    } else {
                        
                        let userData: [String: Any] = [
                            "id": user.uid,
                            "email": user.email ?? "",
                            "name": user.email?.components(separatedBy: "@").first ?? "Unknown"
                        ]
                        userRef.setData(userData) { error in
                            if let error = error {
                                completion(.failure(error))
                            } else {
                                completion(.success(()))
                            }
                        }
                    }
                }
            }
        }
    }
}
