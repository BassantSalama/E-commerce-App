//
//  Validator.swift
//  ECommerceApp
//
//  Created by mac on 27/09/2025.
//

import Foundation

enum signUpValidationError: LocalizedError {
    case invalidEmail
    case invalidPassword
    
    var errorDescription: String? {
        switch self {
        case .invalidEmail: return SignUpConstants.Validation.invalidEmail
        case .invalidPassword: return SignUpConstants.Validation.invalidPassword
        }
    }
}

struct signUpValidator {
    static func validate(email: String, password: String) throws {
        let isValidEmail = NSPredicate(format: "SELF MATCHES %@", SignUpConstants.Regex.email)
            .evaluate(with: email)
        
        let isValidPassword = NSPredicate(format: "SELF MATCHES %@", SignUpConstants.Regex.password)
            .evaluate(with: password)
        
        guard isValidEmail else { throw signUpValidationError.invalidEmail }
        guard isValidPassword else { throw signUpValidationError.invalidPassword }
    }
}
