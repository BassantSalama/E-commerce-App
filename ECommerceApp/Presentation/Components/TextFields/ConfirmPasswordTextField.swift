//
//  ConfirmPasswordTextField.swift
//  ECommerceApp
//
//  Created by mac on 22/09/2025.
//

import UIKit

class ConfirmPasswordTextField: PasswordTextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConfirmPassword()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupConfirmPassword()
    }
    
    private func setupConfirmPassword() {
        self.placeholder = "Confirm Password"
    }
}
