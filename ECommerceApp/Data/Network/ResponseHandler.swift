//
//  ResponseHandler.swift
//  ECommerceApp
//
//  Created by mac on 21/09/2025.
//

import Foundation

struct ResponseHandler {
    
    static func handle<T: Decodable>(
        data: Data?,
        response: URLResponse?,
        error: Error?,
        completion: @escaping (Result<T, APIError>) -> Void
    ) {
        //  Network error
        if let error = error {
            completion(.failure(.networkError(error)))
            return
        }
        
        // Validate HTTP response
        guard let http = response as? HTTPURLResponse else {
            completion(.failure(.invalidResponse))
            return
        }
        
        guard let data = data else {
            completion(.failure(.noData))
            return
        }
        
        do {
            //  Decode into GraphQLResponse<T> directly
            let graphQLResponse = try JSONDecoder().decode(GraphQLResponse<T>.self, from: data)
            
            if let errors = graphQLResponse.errors, !errors.isEmpty {
                let combinedMessage = errors.map { $0.message }.joined(separator: "\n")
                completion(.failure(.serverError(statusCode: http.statusCode, message: combinedMessage)))
                return
            }
            
            if let responseData = graphQLResponse.data {
                completion(.success(responseData))
            } else {
                completion(.failure(.noData))
            }
        } catch {
            if let jsonString = String(data: data, encoding: .utf8) {
                print("❌ Failed to decode JSON: \(jsonString)")
            }
            completion(.failure(.decodingError(error)))
        }
    }
}
