//
//  ProductCell.swift
//  ECommerceApp
//
//  Created by mac on 10/10/2025.
//

import UIKit

final class ProductCell: UICollectionViewCell {
    
    // MARK: - Identifier
    static let identifier = HomeConstants.ProductCellConstants.identifier
    
    // MARK: - UI Components
    private let imageView = UIImageView()
    private let favoriteButton = UIButton(type: .system)
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let priceLabel = UILabel()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        setupImageView()
        setupFavoriteButton()
        setupLabels()
        setupLayout()
    }
    
    private func setupImageView() {
        imageView.layer.cornerRadius = HomeConstants.ProductCellConstants.Layout.cornerRadius
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupFavoriteButton() {
        let heartImage = UIImage(systemName: HomeConstants.ProductCellConstants.Images.heart)?
            .withRenderingMode(.alwaysTemplate)
        
        favoriteButton.setImage(heartImage, for: .normal)
        favoriteButton.tintColor = .white
        favoriteButton.backgroundColor = UIColor.black.withAlphaComponent(
            HomeConstants.ProductCellConstants.Layout.favoriteButtonOpacity
        )
        favoriteButton.layer.cornerRadius = HomeConstants.ProductCellConstants.Layout.favoriteButtonCornerRadius
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupLabels() {
        titleLabel.font = .boldSystemFont(ofSize: HomeConstants.ProductCellConstants.FontSizes.title)
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        
        subtitleLabel.font = .systemFont(ofSize: HomeConstants.ProductCellConstants.FontSizes.subtitle)
        subtitleLabel.textColor = .gray
        subtitleLabel.textAlignment = .center
        
        priceLabel.font = .systemFont(ofSize: HomeConstants.ProductCellConstants.FontSizes.price, weight: .semibold)
        priceLabel.textColor = .label
        priceLabel.textAlignment = .center
    }
    
    private func setupLayout() {
        let labelsStack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel, priceLabel])
        labelsStack.axis = .vertical
        labelsStack.spacing = HomeConstants.ProductCellConstants.Layout.stackSpacing
        labelsStack.alignment = .center
        labelsStack.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(imageView)
        contentView.addSubview(favoriteButton)
        contentView.addSubview(labelsStack)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: HomeConstants.ProductCellConstants.Layout.imageHeight),
            
            favoriteButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: HomeConstants.ProductCellConstants.Layout.favoriteButtonPadding),
            favoriteButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -HomeConstants.ProductCellConstants.Layout.favoriteButtonPadding),
            favoriteButton.widthAnchor.constraint(equalToConstant: HomeConstants.ProductCellConstants.Layout.favoriteButtonSize),
            favoriteButton.heightAnchor.constraint(equalToConstant: HomeConstants.ProductCellConstants.Layout.favoriteButtonSize),
            
            labelsStack.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: HomeConstants.ProductCellConstants.Layout.labelsTopPadding),
            labelsStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: HomeConstants.ProductCellConstants.Layout.labelsHorizontalPadding),
            labelsStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -HomeConstants.ProductCellConstants.Layout.labelsHorizontalPadding),
            labelsStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -HomeConstants.ProductCellConstants.Layout.labelsBottomPadding)
        ])
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
