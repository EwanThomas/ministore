import XCTest
@testable import MiniStore

class ProductCellViewModelTests: XCTestCase {
    
    private var subject: ProductCellViewModel!
    private var stubProduct: Product!
    private var mockCart: MockCart!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockCart = MockCart()
        stubProduct = .stub()
        subject = ProductCellViewModel(product: stubProduct, cart: mockCart)
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        mockCart = nil
        stubProduct = nil
        subject = nil
    }
    
    func test_stepperValueDidChange_whenNewValue_greaterThan_cartCount_addsProductToCart() throws {
        mockCart.quantityForProductStub = .stub(product: stubProduct, quantity: 2)
        subject.stepperValueDidChange(newValue: 3)
        XCTAssertEqual(mockCart.addCallCount, 1)
        XCTAssertEqual(mockCart.addSpy, stubProduct)
    }

    func test_stepperValueDidChange_whenNewValue_lessThan_cartCount_removesProductFromCart() throws {
        mockCart.quantityForProductStub = .stub(product: stubProduct, quantity: 3)
        subject.stepperValueDidChange(newValue: 2)
        XCTAssertEqual(mockCart.removeCallCount, 1)
        XCTAssertEqual(mockCart.removeSpy, stubProduct)
    }
    
    func test_title() throws {
        XCTAssertEqual(subject.title, stubProduct.title)
    }
    
    func test_priceText_isEURCurrencyFormatted() throws {
        XCTAssertEqual(subject.priceText, "€100.00")
    }
    
    func test_descriptionText() throws {
        XCTAssertEqual(subject.descriptionText,stubProduct.productDescription)
    }
    
    func test_limit() throws {
        XCTAssertEqual(subject.limit, 5)
    }
    
    func test_cartQuantity_isExpectedValue() throws {
        let mockCart = MockCart()
        let stubProduct = Product.stub()
        mockCart.quantityForProductStub = .stub(product: stubProduct, quantity: 100)
        let subject = ProductCellViewModel(product: stubProduct, cart: mockCart)
        XCTAssertEqual(subject.cartQuantity, 100)
    }
}
