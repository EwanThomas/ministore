import Foundation
@testable import MiniStore

final class MockCart: CartUpdating {
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
    
    var productCountMatchingCallCount: Int = 0
    var productCountMatchingSpy: Product? = nil
    var productCountMatchingStub: Int = 0
    func productCount(matching product: Product) -> Int {
        productCountMatchingCallCount += 1
        productCountMatchingSpy = product
        return productCountMatchingStub
    }
}
