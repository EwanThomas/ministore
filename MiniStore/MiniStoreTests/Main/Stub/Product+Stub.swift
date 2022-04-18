import Foundation
@testable import MiniStore

extension Product {
    static func stub(
        id: Int = 1,
        title: String = "",
        price: Double = 100,
        productDescription: String = "",
        image: String = ""
    ) -> Product {
        return Product(
            id: id,
            title: title,
            price: price,
            productDescription: productDescription,
            image: image
        )
    }
}
