//
//  Coordinator.swift
//  ECommerceApp
//
//  Created by mac on 23/09/2025.
//

import Foundation

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func start()
}
