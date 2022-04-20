import Combine
import XCTest
@testable import MiniStore

class ProductsViewModelTests: XCTestCase {
    
    private var subject: ProductsViewModel!
    private var subscriptions: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        subscriptions = []
        subject = nil
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        subscriptions = nil
        subject = nil
    }
    
    //MARK: loading
    
    func test_reload_withProductsReturned_setLoadingTrueThenFalse() throws {
        simulate(reloading: [Product.stub(), Product.stub(), Product.stub()])
        let expectation = XCTestExpectation(description: "test_reload_withProductsReturned_setLoadingTrueThenFalse")
        subject
            .$loading
            .collectNext(2)
            .sink { values in
                let expectedValues = [true, false]
                XCTAssertEqual(expectedValues, values)
                expectation.fulfill()
            }
            .store(in: &subscriptions)
        
        subject.reload()
        wait(for: [expectation], timeout: 1)
    }
    
    func test_reload_withProductsNotReturned_setLoadingTrueThenFalse() throws {
        simulate(reloading: [])
        let expectation = XCTestExpectation(description: "test_reload_withProductsNotReturned_setLoadingTrueThenFalse")
        subject
            .$loading
            .collectNext(2)
            .sink { values in
                let expectedValues = [true, false]
                XCTAssertEqual(expectedValues, values)
                expectation.fulfill()
            }
            .store(in: &subscriptions)
        
        subject.reload()
        wait(for: [expectation], timeout: 1)
    }
    
    func test_reload_withError_setLoadingTrueThenFalse() throws {
        simulateError()
        let expectation = XCTestExpectation(description: "test_reload_withError_setLoadingTrueThenFalse")
        subject
            .$loading
            .collectNext(2)
            .sink { values in
                let expectedValues = [true, false]
                XCTAssertEqual(expectedValues, values)
                expectation.fulfill()
            }
            .store(in: &subscriptions)
        
        subject.reload()
        wait(for: [expectation], timeout: 1)
    }
}

private extension ProductsViewModelTests {
    func simulate(reloading products: [Product]) {
        subject = ProductsViewModel(actions: .init(reload: {
            products
        }))
    }
    
    func simulateError() {
        subject = ProductsViewModel(actions: .init(reload: {
            throw ProductServiceError.error(description: "")
        }))
    }
}

private extension Published.Publisher {
    func collectNext(_ count: Int) -> AnyPublisher<[Output], Never> {
        self.dropFirst()
            .collect(count)
            .first()
            .eraseToAnyPublisher()
    }
}
