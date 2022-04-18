import Foundation

final class ProductOrder {
    var product: Product
    var quantity: Int
    
    init(
        product: Product,
        quantity: Int
    ) {
        self.product = product
        self.quantity = quantity
    }
}
