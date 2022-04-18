import Combine
import Foundation
import UIKit

final class ProductsViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let viewModel: ProductsViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    init(
        viewModel: ProductsViewModel = ProductsViewModel()
    ) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: ProductsViewController.self), bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    } 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        bind(to: viewModel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.reload()
    }
}

private extension ProductsViewController {
    func bind(to: ProductsViewModel) {
        viewModel.$products
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
            }.store(in: &subscriptions)
    }
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ProductsViewController.cellNib, forCellWithReuseIdentifier: ProductViewCell.identifier)
    }
    
    func viewModel(at indexPath: IndexPath) -> ProductCellViewModel {
        let product = viewModel.products[indexPath.row]
        return ProductCellViewModel(product: product)
    }
}

extension ProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductViewCell.identifier, for: indexPath) as? ProductViewCell else { fatalError() }
        let viewModel = viewModel(at: indexPath)
        cell.configure(with: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  10
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/2, height: collectionViewSize)
    }
}

private extension ProductsViewController {
    static let cellNib = UINib(nibName: "ProductCollectionViewCell", bundle: .main)
}
