//
//  UIViewController+KeyboardHandling.swift
//  ECommerceApp
//
//  Created by mac on 23/09/2025.
//

import UIKit

extension UIViewController {
    func observeKeyboard(for scrollView: UIScrollView) {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        objc_setAssociatedObject(self,
                                 &AssociatedKeys.scrollViewKey,
                                 scrollView,
                                 .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        setupDismissKeyboardGesture()
    }
    
    private struct AssociatedKeys {
        static var scrollViewKey = "keyboardHandling_scrollView"
    }
    
    private var observedScrollView: UIScrollView? {
        return objc_getAssociatedObject(self, &AssociatedKeys.scrollViewKey) as? UIScrollView
    }
    
    @objc private func handleKeyboardWillShow(notification: Notification) {
        guard let scrollView = observedScrollView,
              let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        
        let keyboardHeight = keyboardFrame.cgRectValue.height
        scrollView.contentInset.bottom = keyboardHeight
        scrollView.verticalScrollIndicatorInsets.bottom = keyboardHeight
    }
    
    @objc private func handleKeyboardWillHide(notification: Notification) {
        guard let scrollView = observedScrollView else { return }
        scrollView.contentInset = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
    
    private func setupDismissKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self)
    }
}
