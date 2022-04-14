import Foundation
import UIKit

final class MainViewController: UITabBarController {

    private let tabBarDataSource: ViewControllerDataSource
    
    init(tabBarDataSource: ViewControllerDataSource = TabBarDataSource()) {
        self.tabBarDataSource = tabBarDataSource
        super.init(nibName: String(describing: MainViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewControllers = tabBarDataSource.controllers
    }
}
