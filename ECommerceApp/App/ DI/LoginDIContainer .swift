//
//  LoginDIContainer .swift
//  ECommerceApp
//
//  Created by mac on 24/09/2025.
//

import UIKit

final class LoginDIContainer {
    
    func makeLoginViewController() -> LoginViewController {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let vc = storyboard.instantiateViewController(
            withIdentifier: "LoginViewController"
        ) as! LoginViewController
        vc.viewModel = makeLoginViewModel()
        return vc
    }
    
    func makeLoginViewModel() -> LoginViewModel {
        return LoginViewModel()
    }
}
