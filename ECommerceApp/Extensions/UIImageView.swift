//
//  UIImageView.swift
//  ECommerceApp
//
//  Created by mac on 21/09/2025.
//

import UIKit

extension UIImageView {
    func setImage(from url: URL, network: NetworkService = NetworkManager.shared) {
        // set default placeholder first
        self.image = UIImage(named: "PlaceHolderImage")

        network.loadImage(from: url) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.image = UIImage(data: data)
                case .failure:
                    // fallback to placeholder if failed
                    self?.image = UIImage(named: "PlaceHolderImage")
                }
            }
        }
    }
}
