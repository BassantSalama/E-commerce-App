//
//  HomeEndpoint.swift
//  ECommerceApp
//
//  Created by mac on 14/10/2025.
//

import Foundation

enum HomeEndpoint: APIEndpointConfig {
    case getCollection(handle: String, first: Int, after: String?)
    
    var request: APIRequest {
        switch self {
        case .getCollection(let handle, let first, let after):
            let afterPart = after != nil ? ", after: \"\(after!)\"" : ""
            
            let query = """
            {
              collectionByHandle(handle: "\(handle)") {
                products(first: \(first)\(afterPart)) {
                  edges {
                    node {
                      id
                      title
                      vendor
                      images(first: 1) {
                        edges {
                          node { src }
                        }
                      }
                      variants(first: 1) {
                        edges {
                          node {
                            price {
                              amount
                            }
                          }
                        }
                      }
                    }
                  }
                  pageInfo {
                    hasNextPage
                    endCursor
                  }
                }
              }
            }
            """
            
            return APIRequestBuilder(url: EndPointsURLs.shopifyURL)
                .setHeaders(EndPointsURLs.headers)
                .setQuery(query)
                .build()
        }
    }
}
