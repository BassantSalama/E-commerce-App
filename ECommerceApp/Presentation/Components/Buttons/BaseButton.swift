//
//  BaseButton.swift
//  ECommerceApp
//
//  Created by mac on 22/09/2025.
//

import UIKit

@IBDesignable
class BaseButton: UIButton {
    
    // MARK: - Customizable Properties
    @IBInspectable var cornerRadius: CGFloat = 26 {
        didSet { updateConfig() }
    }
    
    @IBInspectable var buttonTitle: String? {
        didSet { updateConfig() }
    }
    
    @IBInspectable var backGroundColor: UIColor = AppColors.primary {
        didSet { updateConfig() }
    }
    
    @IBInspectable var textColor: UIColor = .white {
        didSet { updateConfig() }
    }
    
    @IBInspectable var topInset: CGFloat =  10{
        didSet { updateConfig() }
    }
    
    @IBInspectable var leadingInset: CGFloat = 32{
        didSet { updateConfig() }
    }
    
    @IBInspectable var bottomInset: CGFloat = 10 {
        didSet { updateConfig() }
    }
    
    @IBInspectable var trailingInset: CGFloat = 32 {
        didSet { updateConfig() }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConfig()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupConfig()
    }
    
    // MARK: - Config Setup
    private func setupConfig() {
        var config = UIButton.Configuration.filled()
        config.title = buttonTitle ?? self.title(for: .normal)
        self.configuration = config
        updateConfig()
    }
    
    private func updateConfig() {
        guard var config = self.configuration else { return }
        
        config.title = buttonTitle ?? self.title(for: .normal)
        config.baseBackgroundColor = backGroundColor
        config.baseForegroundColor = textColor
        config.cornerStyle = .fixed
        config.contentInsets = NSDirectionalEdgeInsets(
            top: topInset,
            leading: leadingInset,
            bottom: bottomInset,
            trailing: trailingInset
        )
        
        self.configuration = config
        self.layer.cornerRadius = cornerRadius
    }
    
}
