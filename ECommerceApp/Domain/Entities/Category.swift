//
//  CategoryItem.swift
//  ECommerceApp
//
//  Created by mac on 09/11/2025.
//

import Foundation

struct Category: Identifiable, Hashable {
    let id: String
    let imageURL: URL?
}

// Response struct للـNetworking
struct CategoryCollectionResponse: Decodable {
    let collectionByHandle: CategoryCollection
    
    struct CategoryCollection: Decodable {
        let products: Products
        
        struct Products: Decodable {
            let edges: [ProductEdge]
            
            struct ProductEdge: Decodable {
                let node: ProductNode
                
                struct ProductNode: Decodable {
                    let id: String
                    let images: Images
                    
                    struct Images: Decodable {
                        let edges: [ImageEdge]
                        
                        struct ImageEdge: Decodable {
                            let node: ImageNode
                            
                            struct ImageNode: Decodable {
                                let src: String
                            }
                        }
                    }
                    
                    var imageURL: URL? {
                        if let src = images.edges.first?.node.src {
                            return URL(string: src)
                        }
                        return nil
                    }

                }
            }
        }
    }
}
