import Foundation

struct CartInvoice: Equatable {
    let products: [Product]
    let itemCount: Int
    let total: Double
}
