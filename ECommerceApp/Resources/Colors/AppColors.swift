//
//  AppColors.swift
//  ECommerceApp
//
//  Created by mac on 21/09/2025.
//


import UIKit

struct AppColors {
    static let primary: UIColor = {
        guard let color = UIColor(named: "PrimaryColor") else {
            assertionFailure("⚠️ PrimaryColor not found in Assets!")
            return .systemBlue
        }
        return color
    }()
    
    static let secondary: UIColor = {
        guard let color = UIColor(named: "SecondaryColor") else {
            assertionFailure("⚠️ SecondaryColor not found in Assets!")
            return .systemGray
        }
        return color
    }()
}
