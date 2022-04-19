import Foundation

struct Invoice: Equatable {
    let products: [Product]
    let itemCount: Int
    let total: Double
}
