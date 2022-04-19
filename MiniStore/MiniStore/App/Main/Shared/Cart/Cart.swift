import Combine
import Foundation

protocol Invoiceable {
    var invoicePublisher: PassthroughSubject<Invoice, Never> { get }
}

protocol ProductStorable {
    func add(_ product: Product)
    func remove(_ product: Product)
    func productCount(matching product: Product) -> Int
}

final class Cart: ProductStorable, Invoiceable {
    private(set) var invoicePublisher = PassthroughSubject<Invoice, Never>()
    private var backingStore: [Int: ProductOrder]
    
    static let shared = Cart()
    
    init(orders: [Int: ProductOrder] = [:]) {
        self.backingStore = orders
    }
    
    //MARK: ProductStorable
    
    func add(_ product: Product) {
        upsert(product)
        invoicePublisher.send(Invoice(products: products, itemCount: items, total: total))
    }
    
    func remove(_ product: Product) {
        delete(product)
        invoicePublisher.send(Invoice(products: products, itemCount: items, total: total))
    }
    
    var products: [Product] {
        orders.map { $0.product }
    }
    
    func productCount(matching product: Product) -> Int {
        orderCount(for: product)
    }
}

private extension Cart {
    var orders: [ProductOrder] {
        return backingStore.values.map { $0 }
    }
    
    var total: Double {
        orders.reduce(0) { $0 + $1.total }
    }
    
    var items: Int {
        orders.reduce(0) { $0 + $1.quantity }
    }
    
    func orderCount(for product: Product) -> Int {
        backingStore[product.id]?.quantity ?? 0
    }
    
    func upsert(_ product: Product) {
        if let existingOrder = backingStore[product.id] {
            existingOrder.quantity += 1
        } else {
            let newOrder = ProductOrder(product: product)
            backingStore[product.id] = newOrder
        }
    }
    
    func delete(_ product: Product) {
        if let existingOrder = backingStore[product.id] {
            switch existingOrder.quantity {
            case 1:
                backingStore[product.id] = nil
            default:
                existingOrder.quantity -= 1
            }
        }
    }
}
