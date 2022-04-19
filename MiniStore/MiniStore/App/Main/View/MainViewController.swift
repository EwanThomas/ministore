import Foundation
import UIKit

final class MainViewController: UITabBarController {

    private let tabBarDataSource: ViewControllerDataSource
    
    init(tabBarDataSource: ViewControllerDataSource = TabBarDataSource()) {
        self.tabBarDataSource = tabBarDataSource
        super.init(nibName: String(describing: MainViewController.self), bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewControllers = tabBarDataSource.controllers
    }
}

private extension MainViewController {
    func setup() {
        tabBar.tintColor = .white
        tabBar.barStyle = .black
        tabBar.isTranslucent = false;
    }
}
