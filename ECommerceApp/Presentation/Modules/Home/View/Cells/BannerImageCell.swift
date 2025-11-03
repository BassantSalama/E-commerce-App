//
//  BannerImageCell.swift
//  ECommerceApp
//
//  Created by mac on 11/10/2025.
//

import UIKit

final class BannerImageCell: UICollectionViewCell {
    static let identifier = HomeConstants.BannerImageCellConstants.identifier
    
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupUI() {
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = HomeConstants.BannerImageCellConstants.Layout.cornerRadius
        imageView.clipsToBounds = true
        
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(with url: URL?) {
        guard let url = url else {
            imageView.image = UIImage(named: HomeConstants.BannerImageCellConstants.Images.placeholder)
            return
        }
        imageView.setImage(from: url)
    }
}
