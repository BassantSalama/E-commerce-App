//
//  NetworkManager.swift
//  ECommerceApp
//
//  Created by mac on 21/09/2025.
//

import Foundation

protocol NetworkService {
    func request<T: Decodable>(_ request: APIRequest,completion: @escaping (Result<T, APIError>) -> Void)
    func loadImage(from url: URL,completion: @escaping (Result<Data, APIError>) -> Void)
    func clearImageCache()
}

// MARK: - NetworkManager
final class NetworkManager: NetworkService {
    
    static let shared = NetworkManager()
    private init() {}
    
     let imageCache = NSCache<NSURL, NSData>()
    
    // Generic request
    func request<T: Decodable>(
        _ request: APIRequest,
        completion: @escaping (Result<T, APIError>) -> Void
    ) {
        do {
            let urlRequest = try buildURLRequest(from: request)
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                ResponseHandler.handle(data: data, response: response, error: error, completion: completion)
            }.resume()
        } catch {
            completion(.failure(.networkError(error)))
        }
    }
    
    private func buildURLRequest(from request: APIRequest) throws -> URLRequest {
        var urlRequest = URLRequest(url: request.url)
        urlRequest.httpMethod = "POST"
        request.headers?.forEach { key, value in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        let body: [String: Any] = [
            "query": request.query,
            "variables": request.variables ?? [:]
        ]
        urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return urlRequest
    }
    
    // Load Image with cache
    func loadImage(from url: URL, completion: @escaping (Result<Data, APIError>) -> Void) {
        if let cachedData = imageCache.object(forKey: url as NSURL) {
            completion(.success(cachedData as Data))
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            self?.imageCache.setObject(data as NSData, forKey: url as NSURL)
            completion(.success(data))
        }.resume()
    }
    
    func clearImageCache() {
        imageCache.removeAllObjects()
        print("Image cache cleared.")
    }
}
