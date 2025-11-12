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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupSegmentedControlBinding()
        bindViewModel()
        viewModel.fetchCategories()
      //  segmentedControl.setSelectedSegment("Category")
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
        return viewModel.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        
        let category = viewModel.categories[indexPath.item]
        cell.configure(with: category)
        
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
                    print("Already in Category")
                default:
                    break
                }
            }
            .store(in: &cancellables)
    }
    
    private func bindViewModel() {
        viewModel.$categories
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.categoryCollectionView.reloadData()
            }
            .store(in: &cancellables)
    }

}
