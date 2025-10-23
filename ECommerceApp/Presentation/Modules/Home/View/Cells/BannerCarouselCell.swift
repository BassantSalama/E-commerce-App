//
//  BannerCell.swift
//  ECommerceApp
//
//  Created by mac on 10/10/2025.
//

import UIKit

final class BannerCarouselCell: UICollectionViewCell {
    static let identifier = HomeConstants.BannerCellConstants.identifier
    
    private let bannerCollectionView: UICollectionView
    private let pageControl = UIPageControl()
    private var banners: [Banner] = []
    
    override init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        bannerCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupUI() {
        bannerCollectionView.layer.cornerRadius = HomeConstants.BannerCellConstants.Layout.cornerRadius
        bannerCollectionView.clipsToBounds = true
        bannerCollectionView.isPagingEnabled = true
        bannerCollectionView.showsHorizontalScrollIndicator = false
        bannerCollectionView.dataSource = self
        bannerCollectionView.delegate = self
        bannerCollectionView.register(
            BannerImageCell.self,
            forCellWithReuseIdentifier: BannerImageCell.identifier
        )
        
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = AppColors.primary
        
        contentView.addSubview(bannerCollectionView)
        contentView.addSubview(pageControl)
        bannerCollectionView.translatesAutoresizingMaskIntoConstraints = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bannerCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            bannerCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: HomeConstants.BannerCellConstants.Layout.horizontalInset),
            bannerCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -HomeConstants.BannerCellConstants.Layout.horizontalInset),
            bannerCollectionView.heightAnchor.constraint(equalToConstant: HomeConstants.BannerCellConstants.Layout.bannerHeight),
            
            pageControl.topAnchor.constraint(equalTo: bannerCollectionView.bottomAnchor, constant: HomeConstants.BannerCellConstants.Layout.pageControlTopSpacing),
            pageControl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(with banners: [Banner]) {
        self.banners = banners
        pageControl.numberOfPages = banners.count
        bannerCollectionView.reloadData()
    }
}

extension BannerCarouselCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        banners.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BannerImageCell.identifier,
            for: indexPath
        ) as! BannerImageCell
        
        let banner = banners[indexPath.item]
        cell.configure(with: banner.imageURL)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width,
               height: HomeConstants.BannerCellConstants.Layout.bannerHeight)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.frame.width + 0.5)
        pageControl.currentPage = page
    }
}
