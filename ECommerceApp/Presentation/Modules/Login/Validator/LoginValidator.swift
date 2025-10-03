//
//  Validator.swift
//  ECommerceApp
//
//  Created by mac on 03/10/2025.
//

import Foundation

enum LoginValidationError: LocalizedError {
    case invalidEmail
    case invalidPassword
    
    var errorDescription: String? {
        switch self {
        case .invalidEmail: return LoginConstants.Validation.invalidEmail
        case .invalidPassword: return LoginConstants.Validation.invalidPassword
        }
    }
}

struct LoginValidator {
    static func validate(email: String, password: String) throws {
        let isValidEmail = NSPredicate(format: "SELF MATCHES %@", LoginConstants.Regex.email)
            .evaluate(with: email)
        
        let isValidPassword = NSPredicate(format: "SELF MATCHES %@", LoginConstants.Regex.password)
            .evaluate(with: password)
        
        guard isValidEmail else { throw LoginValidationError.invalidEmail }
        guard isValidPassword else { throw LoginValidationError.invalidPassword }
    }
}
