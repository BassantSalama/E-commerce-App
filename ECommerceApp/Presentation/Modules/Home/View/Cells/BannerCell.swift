//
//  BannerCell.swift
//  ECommerceApp
//
//  Created by mac on 10/10/2025.
//

import UIKit

final class BannerCell: UICollectionViewCell {
    static let identifier = "BannerCell"
    
    private let bannerCollectionView: UICollectionView
    private let pageControl = UIPageControl()
    
    private var banners: [String] = []
    
    override init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        bannerCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupUI() {
        bannerCollectionView.layer.cornerRadius = 12
        bannerCollectionView.clipsToBounds = true
        bannerCollectionView.isPagingEnabled = true
        bannerCollectionView.showsHorizontalScrollIndicator = false
        bannerCollectionView.dataSource = self
        bannerCollectionView.delegate = self
        bannerCollectionView.register(BannerImageCell.self,
                                      forCellWithReuseIdentifier: BannerImageCell.identifier)
        
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = AppColors.primary
        
        contentView.addSubview(bannerCollectionView)
        contentView.addSubview(pageControl)
        bannerCollectionView.translatesAutoresizingMaskIntoConstraints = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bannerCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            bannerCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
            bannerCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6),
            bannerCollectionView.heightAnchor.constraint(equalToConstant: 190),
            
            pageControl.topAnchor.constraint(equalTo: bannerCollectionView.bottomAnchor, constant: 20),
            pageControl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(with banners: [String]) {
        self.banners = banners
        pageControl.numberOfPages = banners.count
        bannerCollectionView.reloadData()
    }
}

extension BannerCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        banners.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BannerImageCell.identifier,
            for: indexPath
        ) as! BannerImageCell
        cell.configure(with: banners[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 190)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.frame.width + 0.5)
        pageControl.currentPage = page
    }
}

