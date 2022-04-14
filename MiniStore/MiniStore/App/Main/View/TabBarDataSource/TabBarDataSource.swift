import Foundation
import UIKit

struct TabBarDataSource: ViewControllerDataSource {
    enum ViewControllerType {
        case product
        case cart
    }

    private let controllerTypes: [ViewControllerType]
    
    init(controllerTypes: [ViewControllerType] = [.product, .cart]) {
        self.controllerTypes = controllerTypes
    }
    
    var controllers: [UIViewController] {
        controllerTypes.map { make(type: $0) }
    }
}

private extension TabBarDataSource {
    func make(type: ViewControllerType) -> UIViewController {
        switch type {
        case .product:
            return productViewController
        case .cart:
            return cartViewController
        }
    }
    
    var productViewController: UIViewController {
        let controller = ProductViewController()
        controller.tabBarItem = UITabBarItem(title: "Products", image: UIImage(named: "someImage.png"), selectedImage: UIImage(named: "otherImage.png"))
        return controller
    }
    
    var cartViewController: UIViewController {
        let controller = CartViewController()
        controller.tabBarItem = UITabBarItem(title: "Store Cart", image: UIImage(named: "someImage.png"), selectedImage: UIImage(named: "otherImage.png"))
        return controller
    }
}
