import Foundation
import UIKit

class NibViewController: UIViewController {
    
    @IBOutlet weak var topContainerView: UIView!
    @IBOutlet weak var bottomContainerView: UIView!
    
    let topViewController = NibTopViewController(nibName: "NibTopViewController", bundle: Bundle.main)
    let bottomViewController = NibBottomViewController(nibName: "NibBottomViewController", bundle: Bundle.main)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        embedViewControllers()
    }
    
    // MARK: Setup
    private func embedViewControllers() {
        addChild(topViewController)
        topContainerView.addSubview(topViewController.view)
        topViewController.view.frame = topContainerView.bounds
        topViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        topViewController.didMove(toParent: self)
        
        addChild(bottomViewController)
        bottomContainerView.addSubview(bottomViewController.view)
        bottomViewController.view.frame = bottomContainerView.bounds
        bottomViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        bottomViewController.didMove(toParent: self)
    }

}
