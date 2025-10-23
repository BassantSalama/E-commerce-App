//
//  GraphQLResponse.swift
//  ECommerceApp
//
//  Created by mac on 14/10/2025.
//

import Foundation

struct GraphQLResponse<T: Decodable>: Decodable {
    let data: T?
    let errors: [GraphQLError]?
}

struct GraphQLError: Decodable {
    let message: String
    let locations: [GraphQLErrorLocation]?
}

struct GraphQLErrorLocation: Decodable {
    let line: Int
    let column: Int
}
