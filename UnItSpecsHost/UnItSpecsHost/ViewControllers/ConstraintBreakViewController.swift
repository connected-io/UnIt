import UIKit

class ConstraintBreakViewController: UIViewController {
    @IBOutlet weak var firstConstraintBreakView: UIView!
    @IBOutlet weak var secondConstraintBreakView: UIView!
    
    @IBOutlet weak var heightConstraint150: NSLayoutConstraint!
    @IBOutlet weak var nonConstraintBreakView: UIView!
    @IBOutlet weak var containerViewOfBadViews: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
