//
//  BaseButton.swift
//  ECommerceApp
//
//  Created by mac on 22/09/2025.
//

import UIKit

class CustomButton: UIButton {
    
    // MARK: - Customizable Properties
    @IBInspectable var cornerRadius: CGFloat = 8 {
           didSet { layer.cornerRadius = cornerRadius }
       }

       @IBInspectable var buttonTitle: String? {
           didSet { setTitle(buttonTitle, for: .normal) }
       }

    @IBInspectable var backGroundColor: UIColor = AppColors.primary {
           didSet { backgroundColor = backGroundColor }
       }

       @IBInspectable var textColor: UIColor = .white {
           didSet { setTitleColor(textColor, for: .normal) }
       }
    

       override init(frame: CGRect) {
           super.init(frame: frame)
           setup()
       }

       required init?(coder: NSCoder) {
           super.init(coder: coder)
           setup()
       }

       private func setup() {
           layer.cornerRadius = cornerRadius
           clipsToBounds = true
           setTitle(buttonTitle, for: .normal)
           backgroundColor = backGroundColor
           setTitleColor(textColor, for: .normal)
          
       }
   }
