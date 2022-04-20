import Foundation
@testable import MiniStore

extension CartInvoice {
    static func stub(
        products: [Product],
        itemCount: Int,
        total: Double
    ) -> CartInvoice {
        return CartInvoice(
            products: products,
            itemCount: itemCount,
            total: total
        )
    }
}
