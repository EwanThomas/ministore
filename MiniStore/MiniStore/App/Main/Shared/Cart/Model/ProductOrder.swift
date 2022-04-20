import Foundation

final class ProductOrder {
    var product: Product
    var quantity: Int
    var total: Double {
        Double(quantity) * product.price
    }
    
    init(
        product: Product,
        quantity: Int = 1
    ) {
        self.product = product
        self.quantity = quantity
    }
}
