import Foundation

final class ProductsViewModel {
    private let service: ProductsServing
    
    @Published var products: Products = []
    
    init(
        service: ProductsServing = ProductService()
    ) {
        self.service = service
    }
    
    func load() {
        Task {
            do {
                products = try await service.load()
            } catch {
                //TODO: 
            }
        }
    }
}
