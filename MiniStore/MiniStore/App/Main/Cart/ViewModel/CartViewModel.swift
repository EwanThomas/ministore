import Combine
import Foundation

final class CartViewModel {
    @Published var products: Products = []
    @Published var numberOfItems: String = ""
    @Published var invoiceTotal: String = ""
    
    private let cart: CartStoring
    private var cancellables: Set<AnyCancellable> = []

    init(
        cart: CartStoring = Cart.shared
    ) {
        self.cart = cart
        bind(to: cart)
    }
}

private extension CartViewModel {
    func bind(to cart: CartStoring) {
        cart.productPublisher.sink { [weak self] products in
            self?.products = products
        }.store(in: &cancellables)
        
        cart.invoicePublisher.sink { [weak self] invoice in
            self?.numberOfItems = "item count: \(invoice.itemCount)"
            self?.invoiceTotal = "total: \(invoice.total)"
        }.store(in: &cancellables)
    }
}

