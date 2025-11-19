//
//  NewArrivalsResponse.swift
//  ECommerceApp
//
//  Created by mac on 11/10/2025.
//

import Foundation

// MARK: - Root Response
struct NewArrivalsResponse: Decodable {
    let data: NewArrivalsData
}

// MARK: - Data
struct NewArrivalsData: Decodable {
    let collectionByHandle: CollectionByHandle
}

// MARK: - Collection
struct CollectionByHandle: Decodable {
    let title: String
    let products: ProductConnection
}

// MARK: - ProductConnection
struct ProductConnection: Decodable {
    let edges: [ProductEdge]
}

struct ProductEdge: Decodable {
    let node: ProductNode
}

// MARK: - Product Node
struct ProductNode: Decodable {
    let id: String
    let title: String
    let description: String?
    let images: ImageConnection
    let variants: VariantConnection
}

// MARK: - Images
struct ImageConnection: Decodable {
    let edges: [ImageEdge]
}

struct ImageEdge: Decodable {
    let node: ImageNode
}

struct ImageNode: Decodable {
    let url: String
}

// MARK: - Variants
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
