//
//  SegmentedControlView.swift
//  ECommerceApp
//
//  Created by mac on 08/10/2025.
//

import UIKit
import Combine

class SegmentedControlView: UIView {
    
    private let stackView = UIStackView()
    private let homeButton = UIButton(type: .system)
    private let categoryButton = UIButton(type: .system)
    private let indicatorView = UIView()
    
    private var selectedButton: UIButton?
    
    private var indicatorLeadingConstraint: NSLayoutConstraint!
    private var indicatorWidthConstraint: NSLayoutConstraint!
    
    let selectionPublisher = PassthroughSubject<String, Never>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        configureButtons()
        configureStackView()
        configureIndicatorView()
        setInitialSelection()
    }
    
    private func configureButtons() {
        configureButtonAppearance()
        configureButtonActions()
    }
    
    private func configureButtonAppearance() {
        setupButtonAppearance(homeButton, title: "Home")
        setupButtonAppearance(categoryButton, title: "Category")
    }
    
    private func configureButtonActions() {
        homeButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        categoryButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    private func setupButtonAppearance(_ button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    private func configureStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(homeButton)
        stackView.addArrangedSubview(categoryButton)
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func configureIndicatorView() {
        indicatorView.backgroundColor = AppColors.primary
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(indicatorView)
        
        
        indicatorWidthConstraint = indicatorView.widthAnchor.constraint(equalTo: homeButton.widthAnchor, multiplier: 0.7)
        indicatorLeadingConstraint = indicatorView.centerXAnchor.constraint(equalTo: homeButton.centerXAnchor)
        
        NSLayoutConstraint.activate([
            indicatorView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            indicatorLeadingConstraint,
            indicatorWidthConstraint,
            indicatorView.heightAnchor.constraint(equalToConstant: 3)
        ])
    }
    
    private func setInitialSelection() {
        selectedButton = homeButton
        homeButton.setTitleColor(AppColors.primary, for: .normal)
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        guard sender != selectedButton else { return }
        
        selectedButton?.setTitleColor(.systemGray, for: .normal)
        sender.setTitleColor(AppColors.primary, for: .normal)
        
        selectedButton = sender
        moveIndicator(to: sender)
        
        if sender == homeButton {
            selectionPublisher.send("Home")
        } else {
            selectionPublisher.send("Category")
        }
    }
    
    private func moveIndicator(to button: UIButton) {
        deactivateOldConstraints()
        updateIndicatorConstraints(for: button)
        animateIndicatorMovement()
    }
    
    private func deactivateOldConstraints() {
        indicatorLeadingConstraint.isActive = false
        indicatorWidthConstraint.isActive = false
    }
    
    private func updateIndicatorConstraints(for button: UIButton) {
        indicatorWidthConstraint = indicatorView.widthAnchor.constraint(equalTo: button.widthAnchor, multiplier: 0.7)
        indicatorLeadingConstraint = indicatorView.centerXAnchor.constraint(equalTo: button.centerXAnchor)
        NSLayoutConstraint.activate([indicatorLeadingConstraint, indicatorWidthConstraint])
    }
    
    private func animateIndicatorMovement() {
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    // MARK: - Selection Control
    func setSelectedSegment(_ segment: String) {
        switch segment {
        case "Home":
            buttonTapped(homeButton)
        case "Category":
            buttonTapped(categoryButton)
        default:
            break
        }
    }
    
}
