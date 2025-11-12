//
//  CategoryViewModel.swift
//  ECommerceApp
//
//  Created by mac on 05/11/2025.
//

import Foundation
import Combine

class CategoryViewModel: ObservableObject {
    
    @Published private(set) var categories: [Category] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var error: APIError?
    
    
    private weak var coordinator: CategoryCoordinator?
    private let useCase: CategoryUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(coordinator: CategoryCoordinator, useCase:CategoryUseCaseProtocol) {
        self.coordinator = coordinator
        self.useCase = useCase
    }
    
    func fetchCategories() {
        isLoading = true
        error = nil
        
        useCase.getCategories()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let err) = completion {
                    self?.error = err
                }
            } receiveValue: { [weak self] categories in
                self?.categories = categories
            }
    
            .store(in: &cancellables)
        
    }
    
    
    func didTapHomeSegment() {
        coordinator?.showHomeScreen()
    }
    
}
