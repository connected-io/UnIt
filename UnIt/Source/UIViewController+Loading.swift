import Foundation
import UIKit
import XCTest

public extension UIViewController {
    static func loadFromNib<T: UIViewController>(named nibName: String? = nil, bundle: Bundle? = nil) -> T {
        let vc = T(
            nibName: nibName ?? String(describing: T.self),
            bundle: bundle
        )
        return vc
    }
    
    static func loadFromStoryboard<T: UIViewController>(named storyboardName: String, withIdentifier identifier: String? = nil, bundle: Bundle? = nil) -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
        let vcIdentifier = identifier ?? String(describing: T.self)
        let vc = storyboard.instantiateViewController(withIdentifier: vcIdentifier) as? T
        if vc == nil {
            NSException(
                name: NSExceptionName(rawValue: "UIViewControllerLoadException"),
                reason: "loaded view controller is not of specified type '\(String(describing: T.self))'",
                userInfo: nil
                )
                .raise()
        }
        return vc! // forced unwrap here is ok because test should've already failed by the point if loaded view controller is not of the correct type
    }
}
