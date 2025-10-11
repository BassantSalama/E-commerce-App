//
//  SectionHeaderView.swift
//  ECommerceApp
//
//  Created by mac on 10/10/2025.
//

import UIKit

final class SectionHeaderView: UICollectionReusableView {
    static let identifier = "SectionHeaderView"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .label
        return label
    }()
    
    private let seeAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(HomeConstants.ButtonTitles.seeAll,for: .normal)
        button.setTitleColor(AppColors.primary, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        button.contentHorizontalAlignment = .right
        button.contentVerticalAlignment = .center
        return button
    }()
    
    var onSeeAllTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupUI() {
        addSubview(titleLabel)
        addSubview(seeAllButton)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        seeAllButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            seeAllButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            seeAllButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            seeAllButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 60)
        ])
        
        seeAllButton.addTarget(self, action: #selector(didTapSeeAll), for: .touchUpInside)
    }
    
    func configure(with title: String, onSeeAllTapped: (() -> Void)? = nil) {
        titleLabel.text = title
        self.onSeeAllTapped = onSeeAllTapped
    }
    
    @objc private func didTapSeeAll() {
        onSeeAllTapped?()
    }
}
