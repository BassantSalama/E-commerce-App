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
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        bindViewModel()
        viewModel.fetchCategories()
    }
    
    private func setupCollectionView() {
        setupLayout()
        registerCells()
        configureCollectionViewProperties()
    }
    
    private func setupLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 24
        layout.itemSize = CGSize(width: view.frame.width - 48, height: 140)
        categoryCollectionView.collectionViewLayout = layout
    }
    
    private func registerCells() {
        categoryCollectionView.register(
            UINib(
                nibName: CategoryConstants.Cells.categoryCellNibName,
                bundle: nil
            ),
            forCellWithReuseIdentifier: CategoryConstants.Cells.categoryCellReuseID
        )
    }
    
    private func configureCollectionViewProperties() {
        categoryCollectionView.dataSource = self
        categoryCollectionView.showsVerticalScrollIndicator = false
    }
}

extension CategoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryConstants.Cells.categoryCellReuseID, for: indexPath) as! CategoryCell
        
        let category = viewModel.categories[indexPath.item]
        cell.configure(with: category)
        
        return cell
    }
    
}
extension CategoryViewController {
    private func bindViewModel() {
        viewModel.$categories
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.categoryCollectionView.reloadData()
            }
            .store(in: &cancellables)
    }
    
}
