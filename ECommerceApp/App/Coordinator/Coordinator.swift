//
//  Coordinator.swift
//  ECommerceApp
//
//  Created by mac on 23/09/2025.
//


import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    func start()
}
