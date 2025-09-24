//
//  LoginUseCaseProtocol.swift
//  ECommerceApp
//
//  Created by mac on 24/09/2025.
//

protocol LoginUseCaseProtocol {
    func execute(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)
}
