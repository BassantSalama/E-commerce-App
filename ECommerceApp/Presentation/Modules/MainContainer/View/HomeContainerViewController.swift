//
//  MainContainerViewController.swift
//  ECommerceApp
//
//  Created by mac on 14/11/2025.
//

import UIKit
import Combine

class MainHomeContainerViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var customNavBar: CustomNavigationBar!
    @IBOutlet weak var segmentedControl: SegmentedControlView!
    @IBOutlet weak var containerView: UIView!
    
    // MARK: - Properties
    private var cancellables = Set<AnyCancellable>()
    private var homeCoordinator: HomeCoordinator?
    private var categoryCoordinator: CategoryCoordinator?
    private var currentViewController: UIViewController?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindSegmentedControl()
        switchToHome() // Show Home as default
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground
        navigationController?.setNavigationBarHidden(true, animated: false)
        segmentedControl.setSelectedSegment("Home")
    }
    
    // MARK: - Switching Child VCs
    private func switchToHome() {
        // Instantiate HomeVC via DI Container
        guard let homeVC = homeCoordinator?.makeHomeViewController() else { return }
        setCurrent(childVC: homeVC)
    }
    
    private func switchToCategory() {
        // Instantiate CategoryVC via DI Container
        guard let categoryVC = categoryCoordinator?.makeCategoryViewController() else { return }
        setCurrent(childVC: categoryVC)
    }
    
    private func setCurrent(childVC: UIViewController) {
        // Remove previous child
        if let current = currentViewController {
            current.willMove(toParent: nil)
            current.view.removeFromSuperview()
            current.removeFromParent()
        }
        
        // Add new child
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        childVC.didMove(toParent: self)
        
        currentViewController = childVC
    }
    
    // MARK: - SegmentedControl Binding
    private func bindSegmentedControl() {
        segmentedControl.selectionPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] selection in
                guard let self = self else { return }
                
                switch selection {
                case "Home":
                    self.switchToHome()
                case "Category":
                    self.switchToCategory()
                default:
                    break
                }
            }
            .store(in: &cancellables)
    }
}
