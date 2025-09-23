//
//  PasswordTextField.swift
//  ECommerceApp
//
//  Created by mac on 22/09/2025.
//

import UIKit

// MARK: - Password TextField
class PasswordTextField: CustomTextField {
    
    private let eyeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        button.tintColor = .gray
        button.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPassword()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupPassword()
    }
    
    private func setupPassword() {
        self.isSecureTextEntry = true
        self.placeholder = "Password"
        
        // Add target
        eyeButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        
        // Container with padding
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 24))
        eyeButton.center = container.center
        container.addSubview(eyeButton)
        
        self.rightView = container
        self.rightViewMode = .always
    }
    
    @objc private func togglePasswordVisibility() {
        self.isSecureTextEntry.toggle()
        
        let imageName = self.isSecureTextEntry ? "eye.slash" : "eye"
        eyeButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
}
