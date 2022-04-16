import Foundation

protocol ProductsServing {
    func load() async throws -> Products
}

enum ProductServiceError: Error {
    case network
}

struct ProductService: ProductsServing {
    private let networkSession: Networking
    
    init(networkSession: Networking = NetworkSession()) {
        self.networkSession = networkSession
    }
    
    func load() async throws -> Products {
        let resource = Resource(path: "/products")
        do {
            return try await networkSession.loadResource(resource: resource)
        } catch NetworkError.badResponse {
            throw ProductServiceError.network
        }
    }
}
