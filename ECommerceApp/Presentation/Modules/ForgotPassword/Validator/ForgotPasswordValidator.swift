//
//  ForgotPassword.swift
//  ECommerceApp
//
//  Created by mac on 05/10/2025.
//

import Foundation

struct ForgotPasswordValidator {
    
    static func validateEmail(_ email: String) -> Bool {
        let regex = ForgotPasswordConstants.Regex.email
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: email)
    }
}
