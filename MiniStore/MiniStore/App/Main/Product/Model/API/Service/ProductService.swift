import Foundation

protocol ProductsServing {
    func load() async throws -> Products
}

enum ProductServiceError: Error {
    case error(description: String)
}

struct ProductService: ProductsServing {
    private let networkSession: Networking
    
    init(networkSession: Networking = NetworkSession()) {
        self.networkSession = networkSession
    }
    
    func load() async throws -> Products {
        do {
            return try await networkSession.load(products)
        } catch {
            throw ProductServiceError.error(description: "an error occurred")
        }
    }
}

private extension ProductService {
    var products: Resource {
        Resource(path: "/products")
    }
}
