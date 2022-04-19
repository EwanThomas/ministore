import Combine
import Foundation

protocol ProductInvoiceable {
    var invoicePublisher: PassthroughSubject<Invoice, Never> { get }
    var invoive: Invoice { get }
}

protocol ProductQuantitying {
    var quantityPublisher: PassthroughSubject<ProductQuantity, Never> { get }
}

protocol ProductStorable {
    func add(_ product: Product)
    func remove(_ product: Product)
    func quantity(for product: Product) -> Int
}

final class Cart: ProductStorable, ProductInvoiceable, ProductQuantitying {
    private var backingStore: [Int: ProductOrder]
    
    static let shared = Cart()
    
    init(orders: [Int: ProductOrder] = [:]) {
        self.backingStore = orders
    }
    
    //MARK: Invoiceable
    
    private(set) var invoicePublisher = PassthroughSubject<Invoice, Never>()
    
    var invoive: Invoice {
        Invoice(products: products, itemCount: invoiceItems, total: invoiceTotal)
    }

    //MARK: ProductQuantitying
    
    private(set) var quantityPublisher = PassthroughSubject<ProductQuantity, Never>()

    //MARK: ProductStorable
    
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

    func quantity(for product: Product) -> Int {
        order(for: product)?.quantity ?? 0
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
        let invoice = Invoice(products: products, itemCount: invoiceItems, total: invoiceTotal)
        invoicePublisher.send(invoice)
    }
    
    func publishQuantityChanged(for product: Product) {
        let productQuantity = ProductQuantity(product: product, quantity: quantity(for: product))
        quantityPublisher.send(productQuantity)
    }
}
