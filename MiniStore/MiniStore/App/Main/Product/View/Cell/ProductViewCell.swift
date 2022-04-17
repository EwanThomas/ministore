import Foundation
import UIKit

final class ProductViewCell: UICollectionViewCell {
    static let identifier = String(describing: ProductViewCell.self)
    
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

private extension ProductViewCell {
    func setup() {
        productStepper.autorepeat = false
        productStepper.wraps = false
        productStepper.maximumValue = 5
    }
}
