//
//  UIViewController.swift
//  ECommerceApp
//
//  Created by mac on 02/10/2025.
//

import UIKit

extension UIViewController {
    
    func showAlert(
        title: String,
        message: String,
        actionTitle: String,
        completion: (() -> Void)? = nil
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default) { _ in
            completion?()
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
}
