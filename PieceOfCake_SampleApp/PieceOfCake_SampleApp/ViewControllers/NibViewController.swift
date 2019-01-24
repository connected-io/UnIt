import Foundation
import UIKit

class NibViewController: UIViewController {
    
    @IBOutlet weak var topContainerView: UIView!
    @IBOutlet weak var bottomContainerView: UIView!
    
    let topViewController = NibTopViewController(nibName: "NibTopViewController", bundle: Bundle.main)
    let bottomViewController = NibBottomViewController(nibName: "NibBottomViewController", bundle: Bundle.main)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("nib: viewDidLoad")
        embedViewControllers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("nib: viewWillAppear:")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("nib: viewDidAppear:")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("nib: viewWillDisappear:")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("nib: viewDidDisappear:")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("nib: viewWillLayoutSubviews")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("nib: viewDidLayoutSubviews")
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
