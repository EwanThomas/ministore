import Combine
import Foundation

final class CartViewModel {
    @Published private(set) var products: Products = []
    @Published private(set) var numberOfItems: String = ""
    @Published private(set) var invoiceTotal: String = ""
    
    private let cart: CartPublishing
    private var cancellables: Set<AnyCancellable> = []

    init(
        cart: CartPublishing = Cart.shared
    ) {
        self.cart = cart
        bind(to: cart)
    }
}

private extension CartViewModel {
    func bind(to cart: CartPublishing) {
        cart.productPublisher.sink { [weak self] products in
            self?.products = products
        }.store(in: &cancellables)
        
        cart.invoicePublisher.sink { [weak self] invoice in
            self?.numberOfItems = "item count: \(invoice.itemCount)"
            self?.invoiceTotal = "total: \(invoice.total.formatted)"
        }.store(in: &cancellables)
    }
}
