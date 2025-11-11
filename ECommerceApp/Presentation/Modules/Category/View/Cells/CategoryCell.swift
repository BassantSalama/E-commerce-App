//
//  CategoryCell.swift
//  ECommerceApp
//
//  Created by mac on 05/11/2025.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        layer.cornerRadius = 16
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 5
        layer.masksToBounds = false
        categoryImageView.layer.cornerRadius = 16
        categoryImageView.contentMode = .scaleAspectFill
        categoryImageView.clipsToBounds = true
    }
    
    func configure(with urlString: String?) {
        if let urlString = urlString, let url = URL(string: urlString) {
            categoryImageView.setImage(from: url)
        } else {
            categoryImageView.image = UIImage(named: CategoryConstants.Images.placeholder)
        }
    }
    
}
