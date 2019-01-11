import UIKit

class LabelCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!

    public func configure(with text: String) {
        titleLabel.text = text
    }

}
