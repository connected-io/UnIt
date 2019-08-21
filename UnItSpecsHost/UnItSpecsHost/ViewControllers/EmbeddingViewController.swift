import Foundation
import UIKit

struct Lifecycle: OptionSet {
    let rawValue: Int
    
    static let didLoad = Lifecycle(rawValue: 1 << 0)
    static let willAppear = Lifecycle(rawValue: 1 << 1)
    static let willLayoutSubviews = Lifecycle(rawValue: 1 << 2)
    static let didLayoutSubviews = Lifecycle(rawValue: 1 << 3)
    static let didAppear = Lifecycle(rawValue: 1 << 4)
}

class EmbeddingViewController: UIViewController {
    
    @IBOutlet weak var topContainerView: UIView!
    @IBOutlet weak var bottomContainerView: UIView!
    
    // tracking which view lifecycle calls have been made
    var lifecycle = Lifecycle(rawValue: 0)

    let topViewController = TopViewController(nibName: "TopViewController", bundle: Bundle.main)
    let bottomViewController = BottomViewController(nibName: "BottomViewController", bundle: Bundle.main)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        embedViewControllers()
        lifecycle = lifecycle.union(.didLoad)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lifecycle = lifecycle.union(.willAppear)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        lifecycle = lifecycle.union(.willLayoutSubviews)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        lifecycle = lifecycle.union(.didLayoutSubviews)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        lifecycle = lifecycle.union(.didAppear)
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
