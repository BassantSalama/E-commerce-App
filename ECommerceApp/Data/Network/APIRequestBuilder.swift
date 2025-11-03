//
//  APIRequestBuilder.swift
//  ECommerceApp
//
//  Created by mac on 21/09/2025.
//

import Foundation

final class APIRequestBuilder {
    private var url: URL
    private var headers: [String: String]?
    private var query: String = ""
    private var variables: [String: Any]?
    
    // Initialize with a base URL
    init(url: URL) {
        self.url = url
    }
    
    // Set headers (e.g. Shopify Access Token)
    @discardableResult
    func setHeaders(_ headers: [String: String]?) -> Self {
        self.headers = headers
        return self
    }
    
    // Set GraphQL query
    @discardableResult
    func setQuery(_ query: String) -> Self {
        self.query = query
        return self
    }
    
    // Set GraphQL variables (optional)
    @discardableResult
    func setVariables(_ variables: [String: Any]?) -> Self {
        self.variables = variables
        return self
    }
    
    // Build final APIRequest
    func build() -> APIRequest {
        return APIRequest(
            url: url,
            headers: headers,
            query: query,
            variables: variables
        )
    }
}
