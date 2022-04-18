import Foundation

final class CartViewModel {
    private let actions: Actions
    
    @Published var products: Products = []
    
    init(
        actions: Actions = .init()
    ) {
        self.actions = actions
    }
    
    func load() {
        products = actions.reload()
    }
}

extension CartViewModel {
    struct Actions {
        var reload: () -> Products
    }
}

extension CartViewModel.Actions {
    init(cart: CartStoring = Cart.shared) {
        reload = {
            cart.products
        }
    }
}
