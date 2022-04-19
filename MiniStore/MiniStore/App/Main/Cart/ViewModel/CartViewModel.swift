import Combine
import Foundation

final class CartViewModel {
    @Published private(set) var products: Products = []
    @Published private(set) var numberOfItems: String = ""
    @Published private(set) var invoiceTotal: String = ""
    
    private let cart: ProductInvoiceable
    private var subscriptions: Set<AnyCancellable> = []

    init(
        cart: ProductInvoiceable = Cart.shared
    ) {
        self.cart = cart
        bind(to: cart)
    }
}

private extension CartViewModel {
    func bind(to cart: ProductInvoiceable) {
        cart.invoicePublisher.sink { [weak self] invoice in
            self?.products = invoice.products
            self?.numberOfItems = "item count: \(invoice.itemCount)"
            self?.invoiceTotal = "total: \(invoice.total.formatted)"
        }.store(in: &subscriptions)
    }
}
