//
//  UITextField.swift
//  ECommerceApp
//
//  Created by mac on 23/09/2025.
//
import UIKit

extension UITextField {
    func enableNextField(nextField: UITextField?) {
        self.returnKeyType = nextField == nil ? .done : .next
        self.addTarget(self, action: #selector(nextOrDismiss), for: .editingDidEndOnExit)
        objc_setAssociatedObject(self, &AssociatedKeys.nextFieldKey, nextField, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    @objc private func nextOrDismiss() {
        if let nextField = objc_getAssociatedObject(self, &AssociatedKeys.nextFieldKey) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            self.resignFirstResponder()
        }
    }
    
    private struct AssociatedKeys {
        static var nextFieldKey = "nextFieldKey"
    }
}
