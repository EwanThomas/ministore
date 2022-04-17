import Combine
import Foundation
import UIKit

final class CartViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let viewModel: ProductsViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    init(
        viewModel: ProductsViewModel = ProductsViewModel()
    ) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: CartViewController.self), bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

private extension CartViewController {
    func bind(to: ProductsViewModel) {
     
    }
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CartViewController.cellNib, forCellWithReuseIdentifier: ProductViewCell.identifier)
    }
    
    func viewModel(at indexPath: IndexPath) -> ProductCellViewModel {
        let product = viewModel.products[indexPath.row]
        return ProductCellViewModel(product: product)
    }
}

extension CartViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductViewCell.identifier, for: indexPath) as? ProductViewCell else { fatalError() }
        let viewModel = viewModel(at: indexPath)
        cell.configure(with: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.products.count
    }
}

private extension CartViewController {
    static let cellNib = UINib(nibName: "CartCollectionViewCell", bundle: .main)
}
