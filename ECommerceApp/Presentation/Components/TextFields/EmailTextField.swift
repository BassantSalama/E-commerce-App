//
//  EmailTextField.swift
//  ECommerceApp
//
//  Created by mac on 22/09/2025.
//

import UIKit

@IBDesignable
class EmailTextField: BaseTextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupEmail()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupEmail()
    }
    
    private func setupEmail() {
        self.placeholder = "Email"
        self.keyboardType = .emailAddress
        self.autocapitalizationType = .none
        
    }
}
