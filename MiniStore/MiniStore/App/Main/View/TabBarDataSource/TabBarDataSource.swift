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
        let controller = ProductsViewController()
        let config = UIImage.SymbolConfiguration(scale: .large)
        let icon = UIImage(systemName: "bag", withConfiguration: config)
        controller.tabBarItem = UITabBarItem(title: "Products", image: icon, selectedImage: icon)
        return controller
    }
    
    var cartViewController: UIViewController {
        let controller = CartViewController()
        let config = UIImage.SymbolConfiguration(scale: .large)
        let icon = UIImage(systemName: "cart.fill", withConfiguration: config)
        controller.tabBarItem = UITabBarItem(title: "Store Cart", image: icon, selectedImage: icon)
        return controller
    }
}

