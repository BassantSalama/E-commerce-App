//
//  BannerCarouselCell2.swift
//  ECommerceApp
//
//  Created by mac on 03/11/2025.
//

import UIKit

class BannerCarouselCell: UICollectionViewCell {
    
    static let identifier = HomeConstants.BannerCellConstants.identifier
    
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    private var banners: [Banner] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
        setupCollectionView()
        setupPageControl()
    }
}

// MARK: - Setup Methods 
private extension BannerCarouselCell {
    
    func setupLayout() {
        if let layout = bannerCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
            layout.sectionInset = .zero
        }
    }
    
    func setupCollectionView() {
        bannerCollectionView.layer.cornerRadius = HomeConstants.BannerCellConstants.Layout.cornerRadius
        bannerCollectionView.clipsToBounds = true
        bannerCollectionView.isPagingEnabled = true
        bannerCollectionView.showsHorizontalScrollIndicator = false
        bannerCollectionView.dataSource = self
        bannerCollectionView.delegate = self
        
        bannerCollectionView.register(
            UINib(nibName: "BannerImageCell", bundle: nil),
            forCellWithReuseIdentifier: BannerImageCell.identifier
        )
    }
    
    func setupPageControl() {
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = AppColors.primary
    }
}
// MARK: - Public Configuration
extension BannerCarouselCell {
    func configure(with banners: [Banner]) {
        self.banners = banners
        pageControl.numberOfPages = banners.count
        bannerCollectionView.reloadData()
        bannerCollectionView.layoutIfNeeded()
    }
}

// MARK: - UICollectionView Delegates
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
