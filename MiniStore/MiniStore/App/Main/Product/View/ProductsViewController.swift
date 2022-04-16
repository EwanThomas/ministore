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
        viewModel.load()
    }
}

private extension ProductsViewController {
    func bind(to: ProductsViewModel) {
        viewModel.$products
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] _ in
                self.collectionView.reloadData()
            }.store(in: &subscriptions)
    }
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ProductCollectionViewCell.nib, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
    }
}

extension ProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath as IndexPath) as! ProductCollectionViewCell
        cell.configure(with: viewModel.products[indexPath.row])
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

