//
//  BaseTextField.swift
//  ECommerceApp
//
//  Created by mac on 22/09/2025.
//



import UIKit

@IBDesignable
class BaseTextField: UITextField {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBaseStyle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupBaseStyle()
    }
    
    private func setupBaseStyle() {
        backgroundColor = AppColors.secondary
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray4.cgColor
        textColor = .label
        font = UIFont.systemFont(ofSize: 16)
        tintColor = AppColors.primary
        autocorrectionType = .no
        
        
        // Active / Inactive border color
        addTarget(self, action: #selector(editingBegan), for: .editingDidBegin)
        addTarget(self, action: #selector(editingEnded), for: .editingDidEnd)
    }
    
    @objc private func editingBegan() {
        layer.borderColor = AppColors.primary.cgColor
    }
    
    @objc private func editingEnded() {
        layer.borderColor = UIColor.systemGray4.cgColor
    }
}

