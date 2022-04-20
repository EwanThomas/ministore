import Combine
import Foundation
import UIKit

final class CartViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var itemCountLabel: UILabel!
    @IBOutlet weak var checkoutTotalLabel: UILabel!
    
    private let viewModel: CartViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    init(
        viewModel: CartViewModel = CartViewModel()
    ) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: CartViewController.self), bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        bind(to: viewModel)
    }
}

private extension CartViewController {
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CartViewController.cellNib, forCellWithReuseIdentifier: ProductViewCell.identifier)
    }
    
    func bind(to: CartViewModel) {
        viewModel.$products
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
                self?.update()
            }.store(in: &subscriptions)
    }
    
    func update() {
        itemCountLabel.text = viewModel.numberOfItems
        checkoutTotalLabel.text = viewModel.invoiceTotal
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  10
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize, height: collectionViewSize/2)
    }
}

private extension CartViewController {
    static let cellNib = UINib(nibName: "CartCollectionViewCell", bundle: .main)
}
