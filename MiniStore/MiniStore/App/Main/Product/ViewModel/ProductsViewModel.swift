import Foundation

final class ProductsViewModel {
    private let actions: Actions
    
    @Published private(set) var products: Products = []
    
    init(
        actions: Actions = .init()
    ) {
        self.actions = actions
    }
    
    func reload() {
        Task {
            do {
                products = try await actions.reload()
            } catch {
                throw error
            }
        }
    }
}

extension ProductsViewModel {
    struct Actions {
        var reload: () async throws -> Products
    }
}

extension ProductsViewModel.Actions {
    init(service: ProductsServing = ProductService()) {
        reload = {
            try await service.load()
        }
    }
}
