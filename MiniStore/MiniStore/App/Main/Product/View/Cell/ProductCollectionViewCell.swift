import Foundation
import UIKit

final class ProductCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: ProductCollectionViewCell.self)
    static let nib = UINib(nibName: identifier, bundle: .main)
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var productStepper: UIStepper!
    
    private var viewModel: ProductCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    func configure(with viewModel: ProductCellViewModel) {
        self.viewModel = viewModel
        priceLabel.text = viewModel.priceText
        descriptionLabel.text = viewModel.descriptionText
        productStepper.value = Double(viewModel.numberInCart)
    }
    
    @IBAction func didTapProduct(_ sender: UIStepper) {
        viewModel?.stepperValueDidChange(newValue: UInt(sender.value))
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
}

private extension ProductCollectionViewCell {
    func setup() {
        productStepper.autorepeat = false
        productStepper.wraps = false
        productStepper.maximumValue = 5
    }
}
