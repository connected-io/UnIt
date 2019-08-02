import Foundation
import UIKit

public extension UIView {
    
    /**
     Checks the view's subviews and identifies which ones are partially or entirely off-screen.
     - returns: An array of **UIView** that are partially/entirely not in the view's bounds.
     */
    func subviewsOutOfBounds() -> [UIView] {
        return views(ofType: UIView.self) { subview in
            let rect = self.findOverlappedArea(with: subview)
            return !subview.isSizeRoughlyEqualTo(rect: rect)
        }
    }
    
    /**
     Checks the view's subviews and identifies which ones are partially off-screen.
     - returns: An array of **UIView** that are partially not in the view's bounds.
     */
    func subviewsPartiallyOutOfBounds() -> [UIView] {
        return views(ofType: UIView.self) { subview in
            let rect = self.findOverlappedArea(with: subview)
            return self != subview &&
                subview.isSizeRoughlyEqualTo(rect: rect) && rect.size != CGSize.zero
        }
    }
    
    /**
     Checks the view's subviews and identifies which ones are entirely off-screen.
     - returns: An array of **UIView** that are entirely not in the view's bounds.
     */
    func subviewsEntirelyOutOfBounds() -> [UIView] {
        return views(ofType: UIView.self) { subview in
            let rect = self.findOverlappedArea(with: subview)
            return self != subview && rect.size == CGSize.zero && subview.isTrulyVisible
        }
    }
    
}
