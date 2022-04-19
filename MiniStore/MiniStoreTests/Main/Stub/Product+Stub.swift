import Foundation
@testable import MiniStore

extension Product {
    static func stub(
        id: Int = 1,
        title: String = "Rain Jacket",
        price: Double = 100.00,
        productDescription: String = "Casual wear",
        image: String = "https://fakestoreapi.com/img/61pHAEJ4NML._AC_UX679_.jpg"
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
