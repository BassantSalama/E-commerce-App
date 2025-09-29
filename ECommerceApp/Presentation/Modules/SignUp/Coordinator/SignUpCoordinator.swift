//
//  SignUpCoordinator.swift
//  ECommerceApp
//
//  Created by mac on 29/09/2025.
//

import UIKit

// MARK: - SignUpCoordinator
class SignUpCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: Coordinator?
    
    init(navigationController: UINavigationController, parentCoordinator: Coordinator? = nil) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    func start() {
        // Add self to parent's child coordinators
        parentCoordinator?.addChildCoordinator(self)
        
        guard let signUpVC = makeSignUpViewController() else { return }
        navigationController.pushViewController(signUpVC, animated: true)
    }
    
    private func makeSignUpViewController() -> SignUpViewController? {
        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
        guard let signUpVC = storyboard.instantiateViewController(
            withIdentifier: "SignUpViewController"
        ) as? SignUpViewController else { return nil }
        
        signUpVC.viewModel = SignUpDIContainer.shared.getSignUpViewModel(coordinator: self)
        return signUpVC
    }
}
