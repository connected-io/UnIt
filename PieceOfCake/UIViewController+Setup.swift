import Foundation

/**
 Screensizes and scale factor from: https://www.paintcodeapp.com/news/ultimate-guide-to-iphone-resolutions
 */
public enum Device {
    case iPhoneSE
    case iPhone6
    case iPhone6Plus
    case iPhone6S
    case iPhone6SPlus
    case iPhone7
    case iPhone7Plus
    case iPhone8
    case iPhone8Plus
    case iPhoneX
    case iPhoneXR
    case iPhoneXS
    case iPhoneXSMax
    
    var dimensions: (screensize: CGSize, scaleFactor: CGFloat) {
        switch self {
        case .iPhoneSE:
            return (CGSize(width: 320, height: 568), 2.0)
        case .iPhone6, .iPhone6S, .iPhone7, .iPhone8:
            return (CGSize(width: 375, height: 667), 2.0)
        case .iPhone6Plus, .iPhone6SPlus:
            return (CGSize(width: 375, height: 667), 3.0)
        case .iPhone7Plus, .iPhone8Plus:
            return (CGSize(width: 414, height: 736), 3.0)
        case .iPhoneX, .iPhoneXS:
            return (CGSize(width: 375, height: 812), 3.0)
        case .iPhoneXR:
            return (CGSize(width: 414, height: 896), 2.0)
        case .iPhoneXSMax:
            return (CGSize(width: 414, height: 896), 3.0)
        }
    }
}

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
    
    func kickUIKit(for device:Device) {
        let _ = self.view
        self.view.frame = CGRect(origin: CGPoint.zero, size: device.dimensions.screensize)
        self.view.contentScaleFactor = device.dimensions.scaleFactor
        self.viewWillAppear(false)
        self.view.layoutIfNeeded() // Handles any view changes after viewWillAppear if needed.
        self.viewDidAppear(false)
        self.view.layoutIfNeeded() // Handles any view changes after viewDidAppear if needed.
    }
    
    /**
     If you want to test your **UIViewController** for constraint conflicts, call this method **BEFORE** kickUIKit(). Afterwards you can test your view controller
     for conflicting constraints with viewController.conflictingConstraints. Your view controller will now be able to handle constraint conflicts.
     - Warning: This function uses swizzling to change a **PRIVATE** UIView function: (engine:willBreakConstraint:dueToMutuallyExclusiveConstraints:)'s implementation in order to capture the conflicting constraints. Calling this once will affect the rest of the app.
     */

    func setupToCaptureConflictingConstraints() {
        view.setupToCaptureConflictingConstraints()
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

    static func loadAndSetupViewControllerFromStoryboard<T: UIViewController>(_ storyboardName: String, _ identifier: String? = nil, _ device: Device, _ bundle: Bundle = Bundle.main, shouldCaptureConstraintBreaks: Bool = false) -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
        let vcTypeName = String(describing: self)
        let vcIdentifier = identifier ?? vcTypeName
        
        let viewController = storyboard.instantiateViewController(withIdentifier: vcIdentifier) as! T
        if (shouldCaptureConstraintBreaks) {
            viewController.setupToCaptureConflictingConstraints()
        }
        viewController.kickUIKit(for: device)
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

    static func loadAndSetupViewControllerFromNib<T: UIViewController>(_ nibName: String, _ klass: T.Type, _ device: Device, _ bundle: Bundle = Bundle.main, shouldCaptureConstraintBreaks: Bool = false) -> T {
        let viewController = klass.init(nibName: nibName, bundle: bundle)
        if (shouldCaptureConstraintBreaks) {
            viewController.setupToCaptureConflictingConstraints()
        }
        let viewController = klass.init(nibName: nibName, bundle: bundle)
        viewController.kickUIKit(for: device)
        return viewController
    }
}
