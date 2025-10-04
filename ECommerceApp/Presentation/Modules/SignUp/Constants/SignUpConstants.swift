//
//  SignUpConstants.swift
//  ECommerceApp
//
//  Created by mac on 03/10/2025.
//

import Foundation

enum SignUpConstants {
    
    enum StoryboardConstants {
        static let name = "SignUp"
        static let viewControllerID = "SignUpViewController"
    }
    
    enum Alerts {
        static let successTitle = "Success"
        static let successMessage = "Account created successfully!"
        static let errorTitle = "Error"
        static let passwordMismatch = "Passwords do not match."
        static let continueAction = "Continue"
        static let okAction = "OK"
    }
    
    enum Validation {
        static let invalidEmail = "Please enter a valid email address."
        static let invalidPassword = "Please enter a valid password."
    }
    
    enum Regex {
        static let email = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        static let password = "^(?=.*[A-Z])(?=.*[0-9]).{6,}$"
    }
}
