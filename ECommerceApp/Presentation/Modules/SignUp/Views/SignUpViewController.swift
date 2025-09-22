//
//  SignUpViewController.swift
//  ECommerceApp
//
//  Created by mac on 22/09/2025.
//

import UIKit

class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: EmailTextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: PasswordTextField!
    @IBOutlet weak var confirmPasswordLabel: UILabel!
    @IBOutlet weak var confirmPasswordTextField: ConfirmPasswordTextField!
    @IBOutlet weak var signUpButton: BaseButton!
    @IBOutlet weak var haveAccountLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
