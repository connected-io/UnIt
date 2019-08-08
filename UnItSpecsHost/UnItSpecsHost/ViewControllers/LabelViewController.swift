import UIKit

class LabelViewController: UIViewController {
    @IBOutlet weak var oneLineLabelNoTruncation: UILabel!
    @IBOutlet weak var oneLineLabelWithTruncation: UILabel!
    @IBOutlet weak var twoLineLabelNoTruncation: UILabel!
    @IBOutlet weak var oneLineLabelWithIncreasingFontToTruncate: UILabel!
    @IBOutlet weak var oneLineLabelThatSizeWillDecreaseToTruncate: UILabel!
    @IBOutlet weak var widthConstraintForDecreaseSizeLabel: NSLayoutConstraint!
    @IBOutlet weak var threeLineLabelWithTruncation: UILabel!
    @IBOutlet weak var infiniteLineLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        oneLineLabelWithIncreasingFontToTruncate.font = UIFont(name: oneLineLabelWithIncreasingFontToTruncate.font.fontName, size: 40)
        widthConstraintForDecreaseSizeLabel.constant = 100
        infiniteLineLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    }

}
