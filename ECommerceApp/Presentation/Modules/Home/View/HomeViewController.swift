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
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewAppearance()
        configureSubviews()
        
    }
    
    private func configureViewAppearance() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = true
    }
    
    private func configureSubviews() {
        setupCustomNavBar()
        setupSegmentedControl()
    }
    
    
    private func setupCustomNavBar() {
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
    
    private func setupSegmentedControl() {
        view.addSubview(segmentedControl)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: customNavBar.bottomAnchor, constant: 16),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            segmentedControl.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc private func didTapSearch() {
        print("Search icon tapped")
    }
}
