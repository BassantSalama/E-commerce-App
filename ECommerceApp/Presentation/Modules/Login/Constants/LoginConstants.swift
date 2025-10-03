//
//  LoginConstants.swift
//  ECommerceApp
//
//  Created by mac on 03/10/2025.
//

import Foundation

enum LoginConstants {
    enum Regex {
        static let email = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        static let password = "^(?=.*[A-Z])(?=.*[0-9]).{6,}$"
    }
    
    enum Validation {
        static let invalidEmail = "Please enter a valid email address."
        static let invalidPassword = "Please enter a valid password."
    }
    
    enum Alerts {
        static let errorTitle = "Error"
        static let okAction = "OK"
    }
}
