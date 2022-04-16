import Foundation
import UIKit

final class ProductCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: ProductCollectionViewCell.self)
    static let nib = UINib(nibName: identifier, bundle: .main)
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUp()
    }

    private func setUp() {
        contentView.backgroundColor = .lightGray
        productDescription.numberOfLines = 2
        productImage.backgroundColor = .gray
    }
    
    func configure(with product: Product) {
        productPriceLabel.text = String(product.price)
        productDescription.text = product.productDescription
    }
}
