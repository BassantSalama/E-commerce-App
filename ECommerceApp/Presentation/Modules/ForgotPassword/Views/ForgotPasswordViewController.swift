//
//  ForgotPasswordViewController.swift
//  ECommerceApp
//
//  Created by mac on 22/09/2025.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var forgotPasswordLabel: UILabel!
    @IBOutlet weak var enterEmailLabel: UILabel!
    @IBOutlet weak var enterEmailTextField: EmailTextField!
    @IBOutlet weak var sendButton: BaseButton!
    @IBOutlet weak var backToSignInLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
