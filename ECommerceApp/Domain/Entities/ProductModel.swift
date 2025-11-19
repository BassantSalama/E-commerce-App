//
//  Product.swift
//  ECommerceApp
//
//  Created by mac on 10/10/2025.
//

struct GraphQLDataResponse: Decodable {
    let data: ProductsResponse
}

struct ProductsResponse: Decodable {
    let products: ProductsConnection
}

struct ProductsConnection: Decodable {
    let edges: [ProductEdge]
}

struct ProductEdge: Decodable {
    let node: Product
}

struct Product: Decodable {
    let id: String
    let title: String
    let images: ImageConnection?
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
