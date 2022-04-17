import Foundation

struct ProductCellViewModel {
    var priceText: String { String(product.price) } //TODO: format
    var descriptionText: String { product.productDescription }
    var numberInCart: Int {
        count(numberOf: product)
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
    
    func stepperValueDidChange(newValue: UInt) {
        newValue > numberInCart ? add() : remove()
    }
}

extension ProductCellViewModel {
    struct Actions {
        var add: (_ product: Product) -> Void
        var remove: (_ product: Product) -> Void
        var countOf: (_ product: Product) -> Int
    }
}

extension ProductCellViewModel.Actions {
    init(model: ProductStoring = Cart.shared) {
        add = { product in
            model.add(product)
        }
        remove = { product in
            model.remove(product)
        }
        countOf = { product in
            return model.count(of: product)
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
    
    func count(numberOf product: Product) -> Int {
        return actions.countOf(product)
    }
}
