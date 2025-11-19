//
//  MainContainerViewController.swift
//  ECommerceApp
//
//  Created by mac on 14/11/2025.
//

import UIKit
import Combine

class HomeMainContainerViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var customNavBar: CustomNavigationBar!
    @IBOutlet weak var segmentedControl: SegmentedControlView!
    @IBOutlet weak var containerView: UIView!
    
    // MARK: - Properties
    private var cancellables = Set<AnyCancellable>()
    private var homeCoordinator: HomeCoordinator!
    private var categoryCoordinator: CategoryCoordinator!
    private var currentViewController: UIViewController?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        initializeCoordinators()
        showDefaultScreen()
        bindSegmentedControl()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground
        navigationController?.setNavigationBarHidden(true, animated: false)
        segmentedControl.setSelectedSegment("Home")
    }
    
    // MARK: - Coordinator Initialization
    private func initializeCoordinators() {
        self.homeCoordinator = HomeCoordinator()
        self.categoryCoordinator = CategoryCoordinator()
    }
    
    // MARK: - Default Screen
    private func showDefaultScreen() {
        switchToHome()
    }
    
    // MARK: - Switching Child VCs
    private func switchToHome() {
        guard let homeVC = homeCoordinator.makeHomeViewController() else { return }
        setCurrent(childVC: homeVC)
    }
    
    private func switchToCategory() {
        guard let categoryVC = categoryCoordinator.makeCategoryViewController() else { return }
        setCurrent(childVC: categoryVC)
    }
    
    private func setCurrent(childVC: UIViewController) {
        if let current = currentViewController {
            current.willMove(toParent: nil)
            current.view.removeFromSuperview()
            current.removeFromParent()
        }
        
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        childVC.didMove(toParent: self)
        childVC.view.layoutIfNeeded()
        
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
