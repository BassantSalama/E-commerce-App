//
//  CustomNavigationBar.swift
//  ECommerceApp
//
//  Created by mac on 09/10/2025.
//

import UIKit

final class CustomNavigationBar: UIView {
    
    private let profileImageView = UIImageView()
    private let nameLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let searchButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = .clear
        
        // Profile image
        profileImageView.image = UIImage(systemName: "person.circle")
        profileImageView.tintColor = AppColors.primary
        profileImageView.layer.cornerRadius = 20
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        
        // Name label
        nameLabel.text = "Hi, Jonathan"
        nameLabel.font = .boldSystemFont(ofSize: 16)
        nameLabel.textColor = .label
        
        // Subtitle label
        subtitleLabel.text = "Let's go shopping"
        subtitleLabel.font = .systemFont(ofSize: 13)
        subtitleLabel.textColor = .secondaryLabel
        
        // Search icon
        let searchIcon = UIImage(systemName: "magnifyingglass")
        searchButton.setImage(searchIcon, for: .normal)
        searchButton.tintColor = .label
        
        // Stack for name + subtitle
        let textStack = UIStackView(arrangedSubviews: [nameLabel, subtitleLabel])
        textStack.axis = .vertical
        textStack.spacing = 2
        
        // Left part: profile image + texts
        let leftStack = UIStackView(arrangedSubviews: [profileImageView, textStack])
        leftStack.axis = .horizontal
        leftStack.spacing = 8
        leftStack.alignment = .center
        
        // Whole bar: left side + search icon
        let mainStack = UIStackView(arrangedSubviews: [leftStack, searchButton])
        mainStack.axis = .horizontal
        mainStack.alignment = .center
        mainStack.distribution = .equalSpacing
        mainStack.spacing = 8
        
        addSubview(mainStack)
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 19),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            
            profileImageView.widthAnchor.constraint(equalToConstant: 40),
            profileImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    // For future (optional)
    func configure(name: String, subtitle: String, image: UIImage?) {
        nameLabel.text = name
        subtitleLabel.text = subtitle
        profileImageView.image = image
    }
    
    // Expose action for search button if needed
    func setSearchAction(target: Any?, action: Selector) {
        searchButton.addTarget(target, action: action, for: .touchUpInside)
    }
}
