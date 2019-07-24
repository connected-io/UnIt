
public extension UIViewController {
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
        - device: the device screen size that the test suite is testing against.
     */
    
    func runViewLifecycle(for device: Device) {
        let _ = self.view
        self.view.frame = CGRect(origin: CGPoint.zero, size: device.dimensions.screensize)
        self.view.contentScaleFactor = device.dimensions.scaleFactor
        self.viewWillAppear(false)
        self.view.layoutIfNeeded() // Handles any view changes after viewWillAppear if needed.
        self.viewDidAppear(false)
        self.view.layoutIfNeeded() // Handles any view changes after viewDidAppear if needed.
    }
    
    /**
     Creates a **UIViewController** or subclass from storyboard and also makes sure it's view lifecycle is ran according to UIKit.
     - parameters:
        - storyboardName: name of the storyboard. (i.e. For Main.storyboard you would put "Main").
        - identifier: the identifier of the view controller that exists inside your storyboard.
        - device: the device screen size that the view lifecycle
        - bundle: the bundle where the storyboard exists.
        - shouldCaptureConstraintBreaks: flag to determine if you want the view controller to monitor for constraint conflicts.
     - returns: Your custom view controller from storyboard.
     */

    static func loadAndSetupViewControllerFromStoryboard<T: UIViewController>(
        _ storyboardName: String,
        _ identifier: String? = nil,
        _ device: Device,
        _ bundle: Bundle? = nil,
        shouldCaptureConstraintBreaks: Bool = false) -> T {
        
        let viewController: T = T.loadFromStoryboard(
            named: storyboardName,
            withIdentifier: identifier,
            bundle: bundle
        )
        
        if (shouldCaptureConstraintBreaks) {
            viewController.setupToCaptureConflictingConstraints()
        }
        viewController.runViewLifecycle(for: device)
        return viewController
    }
    
    /**
     Creates a **UIViewController** or subclass from xib and also makes sure it's view lifecycle is ran according to UIKit.
     - parameters:
        - nibName: the name of the xib file. (i.e. For MyView.xib you would put "MyView").
        - klass: the custom view controller class that you want to instantiate.
        - device: the device screen size that the test suite is testing against.
        - bundle: the bundle where the xib file exists.
        - shouldCaptureConstraintBreaks: flag to determine if you want the view controller to monitor for constraint conflicts.
     - returns: Your custom view controller from xib.
     */

    static func loadAndSetupViewControllerFromNib<T: UIViewController>(
        _ nibName: String,
        _ klass: T.Type,
        _ device: Device,
        _ bundle: Bundle? = nil,
        shouldCaptureConstraintBreaks: Bool = false) -> T {
        
        let viewController: T = T.loadFromNib(
            named: nibName,
            bundle: bundle
        )
        
        if (shouldCaptureConstraintBreaks) {
            viewController.setupToCaptureConflictingConstraints()
        }
        viewController.runViewLifecycle(for: device)
        return viewController
    }
}
