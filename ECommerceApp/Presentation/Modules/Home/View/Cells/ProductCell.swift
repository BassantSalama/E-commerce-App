//
//  ProductCell.swift
//  ECommerceApp
//
//  Created by mac on 04/11/2025.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    static let identifier = HomeConstants.ProductCellConstants.identifier
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    // MARK: - Setup
    private func setupUI() {
        imageView.layer.cornerRadius = HomeConstants.ProductCellConstants.Layout.cornerRadius
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        favoriteButton.backgroundColor = UIColor.black.withAlphaComponent(
            HomeConstants.ProductCellConstants.Layout.favoriteButtonOpacity
        )
        favoriteButton.layer.cornerRadius = HomeConstants.ProductCellConstants.Layout.favoriteButtonCornerRadius
        favoriteButton.tintColor = .white
        
        titleLabel.font = .boldSystemFont(ofSize: HomeConstants.ProductCellConstants.FontSizes.title)
        subtitleLabel.font = .systemFont(ofSize: HomeConstants.ProductCellConstants.FontSizes.subtitle)
        subtitleLabel.textColor = .gray
        priceLabel.font = .systemFont(ofSize: HomeConstants.ProductCellConstants.FontSizes.price, weight: .semibold)
    }
    
    // MARK: - Configure
    func configure(with product: Product) {
        titleLabel.text = product.name
        subtitleLabel.text = product.brand
        priceLabel.text = "$\(product.price)"
        
        guard let url = product.imageURL else {
            imageView.image = UIImage(named: HomeConstants.ProductCellConstants.Images.placeholder)
            return
        }
        
        imageView.setImage(from: url)
    }
}
