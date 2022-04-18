import Foundation

struct Product: Codable, Equatable {
    let id: Int
    let title: String
    let price: Double
    let productDescription: String
    let image: String

    enum CodingKeys: String, CodingKey {
        case id, title, price
        case productDescription = "description"
        case image
    }
}

typealias Products = [Product]
