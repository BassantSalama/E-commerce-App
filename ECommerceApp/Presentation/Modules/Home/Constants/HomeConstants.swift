//
//  HomeConstants.swift
//  ECommerceApp
//
//  Created by mac on 06/10/2025.
//

import Foundation
import UIKit

enum HomeConstants {
    
    enum StoryboardConstants {
        
        static let name = "Home"
        static let viewControllerID = "HomeViewController"
    }
    
    enum SectionTitles {
        static let newArrivals = "New Arrivals"
    }
    
    enum ButtonTitles {
        static let seeAll = "See All"
    }
    
    enum HomeLayoutConstants {
        static let customNavBarHeight: CGFloat = 70
        static let segmentedControlTopSpacing: CGFloat = 16
        static let segmentedControlHeight: CGFloat = 40
        static let collectionViewTopSpacing: CGFloat = 20
        static let horizontalPadding: CGFloat = 20
        static let preloadThreshold: CGFloat = 1.5
    }
    
    enum ProductCellConstants {
        
        static let identifier = "ProductCell"
        
        enum Images {
            static let heart = "heart"
            static let placeholder = "PlaceHolderImage"
        }
        
        enum Layout {
            static let cornerRadius: CGFloat = 16
            static let imageHeight: CGFloat = 200
            static let stackSpacing: CGFloat = 6
            static let favoriteButtonSize: CGFloat = 36
            static let favoriteButtonCornerRadius: CGFloat = 18
            static let favoriteButtonOpacity: CGFloat = 0.45
            static let favoriteButtonPadding: CGFloat = 8
            static let labelsTopPadding: CGFloat = 10
            static let labelsHorizontalPadding: CGFloat = 8
            static let labelsBottomPadding: CGFloat = 8
        }
        
        enum FontSizes {
            static let title: CGFloat = 15
            static let subtitle: CGFloat = 13
            static let price: CGFloat = 15
        }
    }
    
    enum BannerCellConstants {
        
        static let identifier = "BannerCell"
        
        enum Layout {
            static let cornerRadius: CGFloat = 16
            static let horizontalInset: CGFloat = 6
            static let bannerHeight: CGFloat = 200
        }
    }
    
    enum BannerImageCellConstants {
        static let identifier = "BannerImageCell"
        
        enum Layout {
            static let cornerRadius: CGFloat = 16
        }
        
        enum Images {
            static let placeholder = "PlaceHolderImage"
        }
    }
    
    enum ViewModelConstants {
        static let preloadThreshold: CGFloat = 1.5
        static let productsPageSize = 10
        static let bannersPageSize = 4
    }
    
    enum LayoutBuilderConstants {
        
        enum BannerSection {
            static let groupWidth: CGFloat = 0.9
            static let groupHeight: CGFloat = 200
            static let interGroupSpacing: CGFloat = 8
            
            static let contentTopInset: CGFloat = 8
            static let contentLeadingInset: CGFloat = 8
            static let contentBottomInset: CGFloat = 16
            static let contentTrailingInset: CGFloat = 8
            
            static var contentInsets: NSDirectionalEdgeInsets {
                NSDirectionalEdgeInsets(
                    top: contentTopInset,
                    leading: contentLeadingInset,
                    bottom: contentBottomInset,
                    trailing: contentTrailingInset
                )
            }
        }
        
        enum ProductSection {
            static let itemWidth: CGFloat = 0.5
            static let itemHeight: CGFloat = 250
            static let groupHeight: CGFloat = 300
            
            static let contentTopInset: CGFloat = 8
            static let contentLeadingInset: CGFloat = 8
            static let contentBottomInset: CGFloat = 16
            static let contentTrailingInset: CGFloat = 8
            
            static let itemTopInset: CGFloat = 8
            static let itemLeadingInset: CGFloat = 8
            static let itemBottomInset: CGFloat = 8
            static let itemTrailingInset: CGFloat = 8
            
            static let headerHeight: CGFloat = 40
            
            static var contentInsets: NSDirectionalEdgeInsets {
                NSDirectionalEdgeInsets(
                    top: contentTopInset,
                    leading: contentLeadingInset,
                    bottom: contentBottomInset,
                    trailing: contentTrailingInset
                )
            }
            
            static var itemInsets: NSDirectionalEdgeInsets {
                NSDirectionalEdgeInsets(
                    top: itemTopInset,
                    leading: itemLeadingInset,
                    bottom: itemBottomInset,
                    trailing: itemTrailingInset
                )
            }
        }
    }
    
}
