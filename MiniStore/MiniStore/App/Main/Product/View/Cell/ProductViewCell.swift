import Combine
import Foundation
import UIKit
import Kingfisher

final class ProductViewCell: UICollectionViewCell {
    static let identifier = String(describing: ProductViewCell.self)
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var productStepper: UIStepper!
    
    private var viewModel: ProductCellViewModel?
    private var subscriptions = Set<AnyCancellable>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
        imageView.image = nil
    }

    func configure(with viewModel: ProductCellViewModel) {
        self.viewModel = viewModel
        bind(to: viewModel)
        titleLabel.text = viewModel.title
        priceLabel.text = viewModel.priceText
        descriptionLabel.text = viewModel.descriptionText
        productStepper.value = Double(viewModel.cartQuantity)
        productStepper.maximumValue = Double(viewModel.limit)
        imageView.kf.setImage(with: viewModel.imageUrl)
    }
    
    @IBAction func didTapProduct(_ sender: UIStepper) {
        viewModel?.stepperValueDidChange(newValue: Int(sender.value))
    }
}

private extension ProductViewCell {
    func setup() {
        productStepper.autorepeat = false
        productStepper.wraps = false
    }
    
    func bind(to viewModel: ProductCellViewModel) {
        viewModel.$cartQuantity
            .receive(on: DispatchQueue.main)
            .sink { [weak self] quantity in
                self?.productStepper.value = Double(quantity)
            }.store(in: &subscriptions)
    }
}
