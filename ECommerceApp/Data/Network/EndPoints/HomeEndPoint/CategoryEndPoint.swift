//
//  CategoryEndPoint.swift
//  ECommerceApp
//
//  Created by mac on 11/11/2025.
//

import Foundation

struct CategoryEndpoint: APIEndpointConfig {
    var request: APIRequest {
        let query = """
        {
          collectionByHandle(handle: "category") {
            products(first: 10) {
              edges {
                node {
                  id
                  images(first: 1) {
                    edges {
                      node { src }
                    }
                  }
                }
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
