//
//  Validator.swift
//  ECommerceApp
//
//  Created by mac on 27/09/2025.
//

import Foundation

enum ValidationError: LocalizedError {
    case invalidEmail
    case invalidPassword
    
    var errorDescription: String? {
        switch self {
        case .invalidEmail: return "Please enter a valid email address."
        case .invalidPassword: return "Please enter a valid password."
        }
    }
}

struct Validator {
    static func validate(email: String, password: String) throws {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let passwordRegex = "^(?=.*[A-Z])(?=.*[0-9]).{6,}$"
        
        let isValidEmail = NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
        let isValidPassword = NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
        
        guard isValidEmail else { throw ValidationError.invalidEmail }
        guard isValidPassword else { throw ValidationError.invalidPassword }
    }
}
