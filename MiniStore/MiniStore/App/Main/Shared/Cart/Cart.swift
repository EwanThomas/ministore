import Combine
import Foundation

protocol CartInvoicePublishing {
    var invoicePublisher: PassthroughSubject<CartInvoice, Never> { get }
    var invoive: CartInvoice { get }
}

protocol ProductStorable {
    func add(_ product: Product)
    func remove(_ product: Product)
    func quantity(for product: Product) -> ProductQuantity
    var quantityPublisher: PassthroughSubject<ProductQuantity, Never> { get }
}

final class Cart: ProductStorable, CartInvoicePublishing {
    private var backingStore: [Int: ProductOrder]
    
    static let shared = Cart()
    
    init(orders: [Int: ProductOrder] = [:]) {
        self.backingStore = orders
    }
    
    //MARK: Invoiceable
    
    private(set) var invoicePublisher = PassthroughSubject<CartInvoice, Never>()
    
    var invoive: CartInvoice {
        let newCartInvoice = CartInvoice(products: products, itemCount: invoiceItems, total: invoiceTotal)
        return newCartInvoice
    }

    //MARK: ProductStorable

    private(set) var quantityPublisher = PassthroughSubject<ProductQuantity, Never>()
    
    func add(_ product: Product) {
        upsert(product)
        
        publishInvoiceChanged()
        publishQuantityChanged(for: product)
    }

    func remove(_ product: Product) {
        delete(product)
        
        publishInvoiceChanged()
        publishQuantityChanged(for: product)
    }

    func quantity(for product: Product) -> ProductQuantity {
        let quantity = order(for: product)?.quantity ?? 0
        let newProductQuantity = ProductQuantity(product: product, quantity: quantity)
        return newProductQuantity
    }
}

private extension Cart {
    
    var products: [Product] {
        orders.map { $0.product }.sorted(by: {$0.id < $1.id} )
    }
  
    var orders: [ProductOrder] {
        return backingStore.values.map { $0 }
    }
    
    func order(for product: Product) -> ProductOrder? {
        backingStore[product.id]
    }
    
    var invoiceTotal: Double {
        orders.reduce(0) { $0 + $1.total }
    }
    
    var invoiceItems: Int {
        orders.reduce(0) { $0 + $1.quantity }
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
    
    //MARK: Publish new state
    
    func publishInvoiceChanged() {
        invoicePublisher.send(invoive)
    }
    
    func publishQuantityChanged(for product: Product) {
        quantityPublisher.send(quantity(for: product))
    }
}
