import Foundation
import Combine

final class ProductCellViewModel {
    var title: String { product.title }
    var priceText: String { product.price.formatted }
    var descriptionText: String { product.productDescription }
    var imageUrl: URL? { URL(string: product.image) }
    var limit: Int { 5 }

    @Published private(set) var cartQuantity: Int = 0
    
    private let product: Product
    private let cart: ProductStorable
    private var subscriptions: Set<AnyCancellable> = []
    
    init(
        product: Product,
        cart: ProductStorable = Cart.shared
    ) {
        self.product = product
        self.cart = cart
        self.cartQuantity = cartQuantity(of: product)
        bind(to: cart)
    }
    
    func stepperValueDidChange(newValue: Int) {
        newValue > cartQuantity(of: product) ? add() : remove()
    }
}

private extension ProductCellViewModel {
    func bind(to cart: ProductStorable) {
        cart.quantityPublisher.sink { [weak self] value in
            guard self?.product == value.product else { return }
            self?.cartQuantity = value.quantity
        }.store(in: &subscriptions)
    }
    
    func add() {
        cart.add(product)
    }
    
    func remove() {
        cart.remove(product)
    }
    
    func cartQuantity(of: Product) -> Int {
        cart.quantity(for: product).quantity
    }
}
