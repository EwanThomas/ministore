import Foundation

protocol CartStoring {
    var products: [Product] { get }
    func add(_ product: Product)
    func remove(_ product: Product)
    func productCount(matching product: Product) -> Int
}

final class Cart: CartStoring {
    static let shared = Cart()
    
    private var checkout: Cart.Checkout
    
    init(checkout: Checkout = Checkout()) {
        self.checkout = checkout
    }
    
    func add(_ product: Product) {
        checkout.add(product)
    }
    
    func remove(_ product: Product) {
        checkout.delete(product)
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
            return 0
        }
        
        func orderCount(for product: Product) -> Int {
            backingStore[product.id]?.quantity ?? 0
        }
        
        func add(_ product: Product) {
            if let existingOrder = backingStore[product.id] {
                existingOrder.quantity += 1
            } else {
                let newOrder = ProductOrder(product: product, quantity: 1)
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
}
