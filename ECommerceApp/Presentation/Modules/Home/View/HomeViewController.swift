//
//  HomeViewController.swift
//  ECommerceApp
//
//  Created by mac on 06/10/2025.
//

import UIKit
import Combine

enum SectionType: Int, CaseIterable {
    case banners
    case products
}

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
        bindViewModel()
        viewModel.fetchAll()
    }
}

// MARK: - Setup
private extension HomeViewController {
    
    func setupView() {
        configureAppearance()
        setupCollectionViewConstraints()
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
        homeCollectionView.register(BannerCarouselCell.self,
                                    forCellWithReuseIdentifier: BannerCarouselCell.identifier)
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
            homeCollectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: HomeConstants.HomeLayoutConstants.collectionViewTopSpacing),
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
            customNavBar.heightAnchor.constraint(equalToConstant: HomeConstants.HomeLayoutConstants.customNavBarHeight)
        ])
        
        customNavBar.setSearchAction(target: self, action: #selector(didTapSearch))
    }
    
    func setupSegmentedControl() {
        view.addSubview(segmentedControl)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: customNavBar.bottomAnchor, constant:  HomeConstants.HomeLayoutConstants.segmentedControlTopSpacing),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: HomeConstants.HomeLayoutConstants.horizontalPadding),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -HomeConstants.HomeLayoutConstants.horizontalPadding),
            segmentedControl.heightAnchor.constraint(equalToConstant: HomeConstants.HomeLayoutConstants.segmentedControlHeight)
        ])
    }
}

// MARK: - Actions
private extension HomeViewController {
    
    @objc func didTapSearch() {
        print("Search icon tapped")
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource , UICollectionViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        SectionType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sectionType = SectionType(rawValue: section) else { return 0 }
        switch sectionType {
        case .banners:
            return 1
        case .products:
            return viewModel.products.count
        }
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
        guard let sectionType = SectionType(rawValue: indexPath.section) else {
            return UICollectionViewCell()
        }
        
        switch sectionType {
        case .banners:
            return configureBannerCell(in: collectionView, at: indexPath)
        case .products:
            return configureProductCell(in: collectionView, at: indexPath)
        }
    }
    
    func configureBannerCell(in collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BannerCarouselCell.identifier,
            for: indexPath) as? BannerCarouselCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: viewModel.banners)
        return cell
    }
    
    func configureProductCell(in collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProductCell.identifier,
            for: indexPath) as? ProductCell else {
            return UICollectionViewCell()
        }
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
        guard let sectionType = SectionType(rawValue: section) else { return }
        switch sectionType {
        case .products:
            header.configure(with: HomeConstants.SectionTitles.newArrivals) {
                print("See All tapped for New Arrivals")
            }
        default:
            break
        }
    }
    
    private func bindViewModel() {
        viewModel.$banners
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.homeCollectionView.reloadSections([SectionType.banners.rawValue])
            }
            .store(in: &cancellables)
        
        viewModel.$products
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.homeCollectionView.reloadSections([SectionType.products.rawValue])
            }
            .store(in: &cancellables)
    }
}
extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollModel = ScrollEventModel(
            offsetY: scrollView.contentOffset.y,
            contentHeight: scrollView.contentSize.height,
            viewHeight: scrollView.frame.size.height
        )
        
        viewModel.handleScrollEvent(scrollModel)
    }
}

