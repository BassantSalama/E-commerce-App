//
//  CategoryViewController.swift
//  ECommerceApp
//
//  Created by mac on 05/11/2025.
//

import UIKit
import Combine

class CategoryViewController: UIViewController {
    
    var viewModel: CategoryViewModel!
    private var cancellables = Set<AnyCancellable>()
    
    @IBOutlet weak var customNavBar: CustomNavigationBar!
    @IBOutlet weak var segmentedControl: SegmentedControlView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    private var categoryImages: [String?] = Array(repeating: CategoryConstants.Images.placeholder, count: 4)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupSegmentedControlBinding()
    }
    
    private func setupCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 24
        layout.itemSize = CGSize(width: view.frame.width - 48, height: 140)
        
        categoryCollectionView.collectionViewLayout = layout
        categoryCollectionView.register(
            UINib(nibName: "CategoryCell", bundle: nil),
            forCellWithReuseIdentifier: "CategoryCell"
        )
        categoryCollectionView.dataSource = self
        categoryCollectionView.showsVerticalScrollIndicator = false
    }
}

extension CategoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "CategoryCell",
            for: indexPath
        ) as! CategoryCell
        
        let imageName = categoryImages[indexPath.item]
        cell.configure(with: imageName)
        return cell
    }
}
extension CategoryViewController {
    private func setupSegmentedControlBinding() {
        segmentedControl.selectionPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] selection in
                guard let self = self else { return }
                switch selection {
                case "Home":
                    self.viewModel.didTapHomeSegment()
                case "Category":
                    self.segmentedControl.setSelectedSegment("Category")
                    print("Already in Category")
                default:
                    break
                }
            }
            .store(in: &cancellables)
    }
}
