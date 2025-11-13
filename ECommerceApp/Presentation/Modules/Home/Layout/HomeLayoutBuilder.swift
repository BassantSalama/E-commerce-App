//
//  HomeLayoutBuilder.swift
//  ECommerceApp
//
//  Created by mac on 10/10/2025.
//

import UIKit

enum HomeLayoutBuilder {
    
    static func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionIndex, _ in
            switch sectionIndex {
            case 0:
                return createBannerSection()
            default:
                return createProductsSection()
            }
        }
    }
    
    // MARK: - Banner Section
    
    private static func createBannerSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(HomeConstants.LayoutBuilderConstants.BannerSection.groupWidth),
                heightDimension: .absolute(HomeConstants.LayoutBuilderConstants.BannerSection.groupHeight)
            ),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.interGroupSpacing = HomeConstants.LayoutBuilderConstants.BannerSection.interGroupSpacing
        section.contentInsets = HomeConstants.LayoutBuilderConstants.BannerSection.contentInsets
        
        return section
    }
    
    // MARK: - Products Section
    
    private static func createProductsSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(HomeConstants.LayoutBuilderConstants.ProductSection.itemWidth),
                heightDimension: .estimated(HomeConstants.LayoutBuilderConstants.ProductSection.itemHeight)
            )
        )
        item.contentInsets = HomeConstants.LayoutBuilderConstants.ProductSection.itemInsets
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(HomeConstants.LayoutBuilderConstants.ProductSection.groupHeight)
            ),
            subitems: [item, item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = HomeConstants.LayoutBuilderConstants.ProductSection.contentInsets
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(HomeConstants.LayoutBuilderConstants.ProductSection.headerHeight)
            ),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]
        
        return section
    }
}
