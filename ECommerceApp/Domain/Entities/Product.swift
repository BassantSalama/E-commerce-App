//
//  Product.swift
//  ECommerceApp
//
//  Created by mac on 14/10/2025.
//

import Foundation

struct GraphQLDataResponse: Decodable {
    let data: CollectionResponse
}

struct CollectionResponse: Decodable {
    let collectionByHandle: CollectionByHandle
}

struct CollectionByHandle: Decodable {
    let products: ProductsConnection
}

struct ProductsConnection: Decodable {
    let edges: [ProductEdge]
    let pageInfo: PageInfo
}
struct ProductsResponse: Decodable {
    let products: [Product]
    let pageInfo: PageInfo
}

struct PageInfo: Decodable {
    let hasNextPage: Bool
    let endCursor: String?
}

struct ProductEdge: Decodable {
    let node: Product
}

struct Product: Decodable, Hashable, Identifiable {
    let id: String
    let title: String
    let vendor: String?
    let images: ImageConnection?
    let variants: VariantConnection?
    
    var name: String { title }
    var brand: String { vendor ?? "Just a Girl" }
    
    var imageURL: URL? {
        guard let src = images?.edges.first?.node.src else { return nil }
        return URL(string: src)
    }
    
    var price: Double {
        guard
            let priceString = variants?.edges.first?.node.price.amount,
            let value = Double(priceString)
        else { return 0.0 }
        return value
    }

    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: Product, rhs: Product) -> Bool {
        lhs.id == rhs.id
    }
}


struct ImageConnection: Decodable {
    let edges: [ImageEdge]
}

struct ImageEdge: Decodable {
    let node: ImageNode
}

struct ImageNode: Decodable {
    let src: String
}
struct VariantConnection: Decodable {
    let edges: [VariantEdge]
}

struct VariantEdge: Decodable {
    let node: VariantNode
}

struct VariantNode: Decodable {
    let price: Price
}

struct Price: Decodable {
    let amount: String
}

