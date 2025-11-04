//
//  BannerImageCell.swift
//  ECommerceApp
//
//  Created by mac on 04/11/2025.
//

import UIKit

class BannerImageCell: UICollectionViewCell {
    
    static let identifier = HomeConstants.BannerImageCellConstants.identifier
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupImageView()
    }
}
// MARK: - Setup Methods 
private extension BannerImageCell {
    
    func setupImageView() {
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = HomeConstants.BannerImageCellConstants.Layout.cornerRadius
        imageView.clipsToBounds = true
    }
}

// MARK: - Public Configuration
extension BannerImageCell {
    
    func configure(with url: URL?) {
        guard let url = url else {
            imageView.image = UIImage(
                named: HomeConstants.BannerImageCellConstants.Images.placeholder
            )
            return
        }
        imageView.setImage(from: url)
    }
}
