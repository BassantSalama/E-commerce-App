//
//  ProductCell.swift
//  ECommerceApp
//
//  Created by mac on 10/10/2025.
//

import UIKit

final class ProductCell: UICollectionViewCell {
    static let identifier = "ProductCell"
    
    private let imageView = UIImageView()
    private let favoriteButton = UIButton(type: .system)
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let priceLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupUI() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let heartImage = UIImage(systemName: "heart")?.withRenderingMode(.alwaysTemplate)
        favoriteButton.setImage(heartImage, for: .normal)
        favoriteButton.tintColor = .white
        favoriteButton.backgroundColor = UIColor.black.withAlphaComponent(0.45)
        favoriteButton.layer.cornerRadius = 18
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = .boldSystemFont(ofSize: 15)
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        
        subtitleLabel.font = .systemFont(ofSize: 13)
        subtitleLabel.textColor = .gray
        subtitleLabel.textAlignment = .center
        
        priceLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        priceLabel.textColor = .label
        priceLabel.textAlignment = .center
        
        let labelsStack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel, priceLabel])
        labelsStack.axis = .vertical
        labelsStack.spacing = 6
        labelsStack.alignment = .center
        labelsStack.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(imageView)
        contentView.addSubview(favoriteButton)
        contentView.addSubview(labelsStack)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            
            favoriteButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 8),
            favoriteButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -8),
            favoriteButton.widthAnchor.constraint(equalToConstant: 36),
            favoriteButton.heightAnchor.constraint(equalToConstant: 36),
            
            labelsStack.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            labelsStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            labelsStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            labelsStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with product: Product) {
        imageView.image = UIImage(named: product.imageName)
        titleLabel.text = product.name
        subtitleLabel.text = product.brand
        priceLabel.text = "$\(product.price)"
    }
}

