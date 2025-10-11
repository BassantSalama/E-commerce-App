//
//  HomeViewController.swift
//  ECommerceApp
//
//  Created by mac on 06/10/2025.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel: HomeViewModel!
    private var cancellables = Set<AnyCancellable>()
    
    private let customNavBar = CustomNavigationBar()
    private let segmentedControl = SegmentedControlView()
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - Setup
private extension HomeViewController {
    
    func setupView() {
        configureAppearance()
        setupLayout()
        reloadData()
    }
}

// MARK: - Appearance
private extension HomeViewController {
    
    func configureAppearance() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = true
        setupCustomNavBar()
        setupSegmentedControl()
        setupCollectionView()
    }
}

// MARK: - Layout
private extension HomeViewController {
    
    func setupLayout() {
        setupCollectionViewConstraints()
    }
}

// MARK: - Data
private extension HomeViewController {
    
    func reloadData() {
        homeCollectionView.reloadData()
    }
}

// MARK: - Collection View Setup
private extension HomeViewController {
    
    func setupCollectionView() {
        configureCollectionViewDelegates()
        registerCollectionViewCells()
        registerCollectionViewHeader()
        applyCollectionViewLayout()
    }
    
    func configureCollectionViewDelegates() {
        homeCollectionView.dataSource = self
        homeCollectionView.delegate = self
    }
    
    func registerCollectionViewCells() {
        homeCollectionView.register(BannerCell.self,
                                    forCellWithReuseIdentifier: BannerCell.identifier)
        homeCollectionView.register(ProductCell.self,
                                    forCellWithReuseIdentifier: ProductCell.identifier)
    }
    
    func  registerCollectionViewHeader() {
        homeCollectionView.register(SectionHeaderView.self,
                                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                    withReuseIdentifier: SectionHeaderView.identifier)
    }
    
    func applyCollectionViewLayout() {
        homeCollectionView.collectionViewLayout = HomeLayoutBuilder.createLayout()
    }
    
    func setupCollectionViewConstraints() {
        homeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            homeCollectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
            homeCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homeCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - Custom NavBar & Segmented Control
private extension HomeViewController {
    
    func setupCustomNavBar() {
        view.addSubview(customNavBar)
        customNavBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            customNavBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            customNavBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customNavBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customNavBar.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        customNavBar.setSearchAction(target: self, action: #selector(didTapSearch))
    }
    
    func setupSegmentedControl() {
        view.addSubview(segmentedControl)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: customNavBar.bottomAnchor, constant: 16),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            segmentedControl.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

// MARK: - Actions
private extension HomeViewController {
    
    @objc func didTapSearch() {
        print("Search icon tapped")
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        section == 0 ? viewModel.banners.count : viewModel.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        sectionCell(for: indexPath, in: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        return headerView(for: indexPath, in: collectionView)
    }
}

// MARK: - CollectionView Helpers
private extension HomeViewController {
    
    func sectionCell(for indexPath: IndexPath, in collectionView: UICollectionView) -> UICollectionViewCell {
        indexPath.section == 0
        ? configureBannerCell(in: collectionView, at: indexPath)
        : configureProductCell(in: collectionView, at: indexPath)
    }
    
    func configureBannerCell(in collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BannerCell.identifier,
            for: indexPath
        ) as! BannerCell
        cell.configure(with: viewModel.banners)
        return cell
    }
    
    func configureProductCell(in collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProductCell.identifier,
            for: indexPath
        ) as! ProductCell
        cell.configure(with: viewModel.products[indexPath.item])
        return cell
    }
    
    func headerView(for indexPath: IndexPath, in collectionView: UICollectionView) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionHeaderView.identifier,
            for: indexPath
        ) as! SectionHeaderView
        
        configureHeader(header, forSection: indexPath.section)
        return header
    }
    
    func configureHeader(_ header: SectionHeaderView, forSection section: Int) {
        if section == 1 {
            header.configure(with: HomeConstants.SectionTitles.newArrivals) {
                print("See All tapped for New Arrivals")
            }
        }
    }
}
