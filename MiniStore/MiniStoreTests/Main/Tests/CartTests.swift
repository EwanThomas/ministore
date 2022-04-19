import Combine
import XCTest
@testable import MiniStore

class CartTests: XCTestCase {
    
    private var subscriptions: Set<AnyCancellable>!
    private var subject: Cart!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        subscriptions = []
        subject = Cart()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        subscriptions = nil
        subject = nil
    }
    
    //MARK: Invoicing
    
    func test_invoice_whenAddingProducts_withSameProductId_returnsExpectedInvoice() throws {
        let product = Product.stub()
        simulateAdding(items: [product, product, product])
        
        let expectedInvoice = Invoice(products: [product], itemCount: 3, total: 300)
        XCTAssertEqual(subject.invoive, expectedInvoice)
    }
    
    func test_invoice_whenAddingProducts_withDifferentProductId_returnsExpectedInvoice() throws {
        let firstProduct = Product.stub(id: 1)
        let secondProduct = Product.stub(id: 2)
        let thirdProduct = Product.stub(id: 3)
        simulateAdding(items: [firstProduct, secondProduct, firstProduct, thirdProduct])
        
        let expectedInvoice = Invoice(products: [firstProduct, secondProduct, thirdProduct], itemCount: 4, total: 400)
        XCTAssertEqual(subject.invoive, expectedInvoice)
    }
    
    func test_invoice_whenRemovingProducts_returnsExpectedInvoice() throws {
        let firstProduct = Product.stub(id: 1)
        let secondProduct = Product.stub(id: 2)
        let thirdProduct = Product.stub(id: 3)
        simulateAdding(items: [firstProduct, secondProduct, firstProduct, thirdProduct])
        
        subject.remove(firstProduct)
        
        let expectedInvoice = Invoice(products: [firstProduct, secondProduct, thirdProduct], itemCount: 3, total: 300)
        XCTAssertEqual(subject.invoive, expectedInvoice)
    }
    
    func test_invoice_whenCarIsEmpry_returnsExpectedInvoice() throws {
        let expectedInvoice = Invoice(products: [], itemCount: 0, total: 0)
        XCTAssertEqual(subject.invoive, expectedInvoice)
    }

    func test_add_publishes_invoice() throws {
        let expectation = self.expectation(description: "test_add_publishes_invoice")
        subject.invoicePublisher.sink { _ in
            expectation.fulfill()
        }.store(in: &subscriptions)
        
        subject.add(.stub())
        waitForExpectations(timeout: 10)
    }
    
    func test_remove_publishes_invoice() throws {
        let expectation = self.expectation(description: "test_remove_publishes_invoice")
        subject.invoicePublisher.sink { _ in
            expectation.fulfill()
        }.store(in: &subscriptions)
        subject.remove(.stub())
        waitForExpectations(timeout: 10)
    }
    
    //MARK: Helper
    
    func simulateAdding(items products: [Product]) {
        products.forEach(subject.add(_:))
    }
    
    func simulateInvoice(
        with products: [Product],
        itemCount: Int,
        total: Double
    ) -> Invoice {
        Invoice(
            products: products,
            itemCount: itemCount,
            total: total
        )
    }
}
