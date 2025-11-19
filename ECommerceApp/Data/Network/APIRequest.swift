//
//  APIRequest.swift
//  ECommerceApp
//
//  Created by mac on 21/09/2025.
//

import Foundation

enum HTTPMethod: String {
    case POST
}

struct APIRequest {
    let url: URL
    let headers: [String: String]?
    let query: String
    let variables: [String: Any]?
    
    init(
        url: URL,
        headers: [String: String]? = nil,
        query: String,
        variables: [String: Any]? = nil
    ) {
        self.url = url
        self.headers = headers
        self.query = query
        self.variables = variables
    }
}
