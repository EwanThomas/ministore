import Foundation

protocol ProductsServing {
    func load() async throws -> Products
}

struct ProductAPI: ProductsServing {
    private let networkSession: Networking
    
    init(networkSession: Networking = NetworkSession()) {
        self.networkSession = networkSession
    }
    
    func load() async throws -> Products {
        let resource = Resource(path: "/products")
        do {
            return try await networkSession.loadResource(resource: resource)
        } catch let error {
            throw error
        }
    }
}
