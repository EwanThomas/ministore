import Foundation

struct ProductCellViewModel {
    var title: String { product.title }
    var priceText: String { product.price.formatted }
    var descriptionText: String { product.productDescription }
    var limit: Int { 5 }
    
    var cartCount: Int {
        quantity(product: product)
    }

    private let product: Product
    private let cart: ProductStorable
    
    init(
        product: Product,
        cart: ProductStorable = Cart.shared
    ) {
        self.product = product
        self.cart = cart
    }
    
    func stepperValueDidChange(newValue: Int) {
        newValue > cartCount ? add() : remove()
    }
}

private extension ProductCellViewModel {
    func add() {
        cart.add(product)
    }
    
    func remove() {
        cart.remove(product)
    }
    
    func quantity(product: Product) -> Int {
        cart.productCount(matching: product)
    }
}
