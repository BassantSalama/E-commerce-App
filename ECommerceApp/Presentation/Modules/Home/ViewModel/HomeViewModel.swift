//
//  HomeViewModel.swift
//  ECommerceApp
//
//  Created by mac on 06/10/2025.
//

import Foundation
import Combine

class HomeViewModel {
    
    // MARK: - Loading State
    struct LoadingState {
        var isLoading: Bool = false
        var isLoadingMore: Bool = false
        var hasNextPage: Bool = true
        var paginationCursor: String? = nil
    }
    
    // MARK: - Properties
    private weak var coordinator: HomeCoordinator?
    private let useCase: HomeUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var banners: [Banner] = []
    @Published private(set) var products: [Product] = []
    @Published private(set) var error: APIError?
    @Published private(set) var isLoading: Bool = false
    
    private var state = LoadingState()
    
    // MARK: - Initialization
    init(coordinator: HomeCoordinator, useCase: HomeUseCaseProtocol) {
        self.coordinator = coordinator
        self.useCase = useCase
    }
    
    // MARK: - Public Methods
    func fetchAll() {
        fetchBanners()
        fetchProducts()
    }
    
    // MARK: - Network Requests
    func fetchBanners() {
        startLoading()
        
        useCase.getBanners(first: HomeConstants.ViewModelConstants.bannersPageSize)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.finishLoading(completion: completion)
            }, receiveValue: { [weak self] banners in
                self?.banners = banners
            })
            .store(in: &cancellables)
    }
    
    func fetchProducts(after cursor: String? = nil) {
        guard !state.isLoadingMore else { return }
        
        if cursor == nil { startLoading() } else { startPagination() }
        
        useCase.getProducts(first: HomeConstants.ViewModelConstants.productsPageSize, after: cursor)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.finishLoading(completion: completion)
            }, receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.state.hasNextPage = response.pageInfo.hasNextPage
                self.state.paginationCursor = response.pageInfo.endCursor
                
                if cursor == nil {
                    self.products = response.products
                } else {
                    self.products.append(contentsOf: response.products)
                }
            })
            .store(in: &cancellables)
    }
    
    // MARK: - Pagination
    func handleScrollEvent(_ scrollModel: ScrollEventModel) {
        guard scrollModel.contentHeight > scrollModel.viewHeight,
              state.hasNextPage,
              !state.isLoading,
              !state.isLoadingMore else { return }
        
        let threshold = HomeConstants.ViewModelConstants.preloadThreshold
        let triggerPoint = scrollModel.contentHeight - (scrollModel.viewHeight * threshold)
        
        if scrollModel.offsetY > triggerPoint {
            loadMoreProductsIfNeeded()
        }
    }
    
    // MARK: - Private Helpers
    private func loadMoreProductsIfNeeded() {
        guard !state.isLoading, state.hasNextPage else { return }
        fetchProducts(after: state.paginationCursor)
    }
    
    private func startLoading() {
        state.isLoading = true
        state.isLoadingMore = false
        isLoading = true
    }
    
    private func startPagination() {
        state.isLoadingMore = true
        isLoading = true
    }
    
    private func finishLoading(completion: Subscribers.Completion<APIError>) {
        state.isLoading = false
        state.isLoadingMore = false
        isLoading = false
        
        if case .failure(let error) = completion {
            self.error = error
        }
    }
}
