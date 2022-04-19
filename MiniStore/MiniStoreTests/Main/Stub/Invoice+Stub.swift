import Foundation
@testable import MiniStore

extension Invoice {
    static func stub(
        products: [Product],
        itemCount: Int,
        total: Double
    ) -> Invoice {
        return Invoice(
            products: products,
            itemCount: itemCount,
            total: total
        )
    }
}
