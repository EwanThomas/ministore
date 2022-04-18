import Combine
import Foundation

protocol CartPublishing {
    var productPublisher: PassthroughSubject<[Product], Never> { get }
    var invoicePublisher: PassthroughSubject<Invoice, Never> { get }
}

protocol CartUpdating {
    func add(_ product: Product)
    func remove(_ product: Product)
    func productCount(matching product: Product) -> Int
}

final class Cart: CartUpdating, CartPublishing {
    private(set) var productPublisher = PassthroughSubject<[Product], Never>()
    private(set) var invoicePublisher = PassthroughSubject<Invoice, Never>()
    
    static let shared = Cart()
    
    private var checkout: Cart.Checkout
    
    private init(checkout: Checkout = Checkout()) {
        self.checkout = checkout
    }
    
    func add(_ product: Product) {
        checkout.add(product)
        productPublisher.send(products)
        let invoice = Invoice(itemCount: checkout.items, total: checkout.total)
        invoicePublisher.send(invoice)
    }
    
    func remove(_ product: Product) {
        checkout.remove(product)
        productPublisher.send(products)
        let invoice = Invoice(itemCount: checkout.items, total: checkout.total)
        invoicePublisher.send(invoice)
    }
    
    var products: [Product] {
        checkout.orders.map { $0.product }
    }
    
    func productCount(matching product: Product) -> Int {
        checkout.orderCount(for: product)
    }
}

extension Cart {
    final class Checkout {
        private var backingStore: [Int: ProductOrder]
        
        init(orders: [Int: ProductOrder] = [:]) {
            self.backingStore = orders
        }
        
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
        
        func add(_ product: Product) {
            if let existingOrder = backingStore[product.id] {
                existingOrder.quantity += 1
            } else {
                let newOrder = ProductOrder(product: product)
                backingStore[product.id] = newOrder
            }
        }
        
        func remove(_ product: Product) {
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
}
