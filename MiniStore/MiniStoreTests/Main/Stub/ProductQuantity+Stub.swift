import Foundation
@testable import MiniStore

extension ProductQuantity {
    static func stub(
        product: Product = .stub(),
        quantity: Int = 1
    ) -> ProductQuantity {
        return ProductQuantity(
            product: product,
            quantity: quantity
        )
    }
}
