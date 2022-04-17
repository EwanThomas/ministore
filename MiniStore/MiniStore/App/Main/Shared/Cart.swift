import Foundation

protocol ProductStoring {
    var total: Double { get }
    func add(_ product: Product)
    func remove(_ product: Product)
    func count(of product: Product) -> Int
}

final class Cart {
    typealias Orders = [Int: [ProductOrder]]
    
    static let shared = Cart()
    
    private(set) var store: Orders
    
    var total: Double {
        return 0
    }
    
    private init(
        store: Orders = [:]
    ) {
        self.store = store
    }
}

extension Cart: ProductStoring {
    func add(_ product: Product) {
        let newOrder = ProductOrder(product: product)
        if var existingOrders = store[product.id] {
            existingOrders.append(newOrder)
            store[product.id] = existingOrders
        } else {
            store[product.id] = [newOrder]
        }
    }
    
    func remove(_ product: Product) {
        if var existingOrders = store[product.id] {
            existingOrders.removeLast()
            store[product.id] = existingOrders
        }
    }
    
    func count(of product: Product) -> Int {
        store[product.id]?.count ?? 0
    }
}

