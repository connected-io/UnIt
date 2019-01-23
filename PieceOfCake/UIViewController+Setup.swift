import Foundation

extension UIViewController {
    /**
     Due to the laziness of UIKit, the view lifecycle does not run properly when instantiating view/view controllers in unit tests. This method makes sure that the viewController's view lifecycle is ran to match UIKit (when a user interacts with the app). It will **roughly** follow the following view lifecycle:
     - viewDidLoad()
     - viewWillAppear(animated: Bool)
     - viewWillLayoutSubviews()
     - viewDidLayoutSubviews()
     - viewDidAppear(animated: Bool)
     - viewWillLayoutSubviews()
     - viewDidLayoutSubviews()
     - parameters:
        - viewController: the **UIViewController** that you want to run the view lifecycle against so it mirrors what UIKit does.
     */
    public func kickUIKit() {
        let _ = self.view
        self.viewWillAppear(false)
        self.view.layoutIfNeeded() // Handles any view changes after viewWillAppear if needed.
        self.viewDidAppear(false)
        self.view.layoutIfNeeded() // Handles any view changes after viewDidAppear if needed.
    }
    
    /**
     Creates a **UIViewController** or subclass from storyboard and also makes sure it's view lifecycle is ran according to UIKit.
     - parameters:
        - storyboardName: name of the storyboard. (i.e. For Main.storyboard you would put "Main").
        - bundle: the bundle where the storyboard exists.
        - identifier: the identifier of the view controller that exists inside your storyboard.
        - shouldCaptureConstraintBreaks: flag to determine if you want the view controller to monitor for constraint conflicts.
     - returns: Your custom view controller from storyboard.
     */
    public static func loadAndSetupViewControllerFromStoryboard<T: UIViewController>(_ storyboardName: String, _ identifier: String? = nil, _ bundle: Bundle = Bundle.main, shouldCaptureConstraintBreaks: Bool = false) -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
        let vcTypeName = String(describing: self)
        let vcIdentifier = identifier ?? vcTypeName
        
        let viewController = storyboard.instantiateViewController(withIdentifier: vcIdentifier) as! T
        if (shouldCaptureConstraintBreaks) {
            viewController.setupToCaptureConflictingConstraints()
        }
        viewController.kickUIKit()
        return viewController
    }
    
    /**
     Creates a **UIViewController** or subclass from xib and also makes sure it's view lifecycle is ran according to UIKit.
     - parameters:
        - nibName: the name of the xib file. (i.e. For MyView.xib you would put "MyView").
        - bundle: the bundle where the xib file exists.
        - klass: the custom view controller class that you want to instantiate.
        - shouldCaptureConstraintBreaks: flag to determine if you want the view controller to monitor for constraint conflicts.
     - returns: Your custom view controller from xib.
     */
    public static func loadAndSetupViewControllerFromNib<T: UIViewController>(_ nibName: String, _ klass: T.Type, _ bundle: Bundle = Bundle.main, shouldCaptureConstraintBreaks: Bool = false) -> T {
        let viewController = klass.init(nibName: nibName, bundle: bundle)
        if (shouldCaptureConstraintBreaks) {
            viewController.setupToCaptureConflictingConstraints()
        }
        viewController.kickUIKit()
        return viewController
    }
}
