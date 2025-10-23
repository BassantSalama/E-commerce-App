//
//  EndPointsURLs.swift
//  ECommerceApp
//
//  Created by mac on 20/10/2025.
//

import Foundation

struct EndPointsURLs {
    static let shopifyURL = URL(string: "https://basant-dev-store.myshopify.com/api/2025-01/graphql.json")!
    static let headers = [
        "X-Shopify-Storefront-Access-Token": "fb74dd6b09eea2895f85882ebb8020c5",
        "Content-Type": "application/json"
    ]
}
