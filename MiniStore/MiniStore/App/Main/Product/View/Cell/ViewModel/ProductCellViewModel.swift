import Foundation

struct ProductCellViewModel {
    var priceText: String { String(product.price) } //TODO: format
    var descriptionText: String { product.productDescription }
    var limitOrder: Int { 5 }
    
    var cartCount: Int {
        quantity(product: product)
    }

    private let actions: Actions
    private let product: Product
    
    init(
        product: Product,
        actions: Actions = .init()
    ) {
        self.product = product
        self.actions = actions
    }
    
    func stepperValueDidChange(newValue: Int) {
        newValue > cartCount ? add() : remove()
    }
}

extension ProductCellViewModel {
    struct Actions {
        var add: (_ product: Product) -> Void
        var remove: (_ product: Product) -> Void
        var quantityOf: (_ product: Product) -> Int
    }
}

extension ProductCellViewModel.Actions {
    init(cart: CartStoring = Cart.shared) {
        add = { product in
            cart.add(product)
        }
        remove = { product in
            cart.remove(product)
        }
        quantityOf = { product in
            cart.productCount(matching: product)
        }
    }
}

private extension ProductCellViewModel {
    func add() {
        actions.add(product)
    }
    
    func remove() {
        actions.remove(product)
    }
    
    func quantity(product: Product) -> Int {
        return actions.quantityOf(product)
    }
}
