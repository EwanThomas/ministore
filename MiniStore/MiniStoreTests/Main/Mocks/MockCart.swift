import Foundation
import Combine
@testable import MiniStore

final class MockCart: ProductStorable {
    var quantityPublisher = PassthroughSubject<ProductQuantity, Never>()
    
    var addCallCount: Int = 0
    var addSpy: Product? = nil
    func add(_ product: Product) {
        addCallCount += 1
        addSpy = product
    }
    
    var removeCallCount: Int = 0
    var removeSpy: Product? = nil
    func remove(_ product: Product) {
        removeCallCount += 1
        removeSpy = product
    }
    
    var quantityForProductCallCount: Int = 0
    var quantityForProductSpy: Product? = nil
    var quantityForProductStub: ProductQuantity = .stub()
    func quantity(for product: Product) -> ProductQuantity {
        quantityForProductCallCount += 1
        quantityForProductSpy = product
        return quantityForProductStub
    }
}
