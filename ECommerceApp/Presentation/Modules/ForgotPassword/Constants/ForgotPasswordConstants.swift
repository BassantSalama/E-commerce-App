//
//  ForgotPasswordConstants.swift
//  ECommerceApp
//
//  Created by mac on 05/10/2025.
//
import Foundation

enum ForgotPasswordConstants {
    
    enum StoryboardConstants {
        static let name = "ForgotPassword"
        static let viewControllerID = "ForgotPasswordViewController"
    }
    
    enum AlertMessages {
        static let successTitle = "Success"
        static let errorTitle = "Error"
        static let successMessage = "Password reset link sent successfully!"
        static let invalidEmail = "Please enter a valid email address."
        static let okAction = "OK"
    }
    
    enum Regex {
        static let email = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
    }
}

