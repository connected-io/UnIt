public extension UIView {
    
    /**
     Checks to see if a **UIView** is actually shown to the user. Checks to see isHidden, alpha,
     height and width and superview visibility.
     - Note: Taken from an Objective-C library called PivotalCoreKit: https://github.com/pivotal-legacy/PivotalCoreKit/blob/master/UIKit/SpecHelper/Extensions/UIControl%2BSpec.m
     */
    var isTrulyVisible: Bool {
        if isHidden {
            return false
        }
        if alpha == 0 {
            return false
        }
        if frame.size.width == 0 || frame.size.height == 0 {
            return false
        }
        if let superview = self.superview {
            return superview.isTrulyVisible
        }
        return true
    }
    
    /**
     This function makes sure that when comparing widths and heights that no precision error occurs by rounding to 2 decimal places. (i.e. 10.666667 != 10.67 even though it falls within an acceptable range).
     - parameters:
     - firstSize: a **CGSize** of the first view.
     - secondSize: a **CGSize** of the second view.
     - returns: A true/false on whether the 2 sizes are equivalent up to 2 decimal places.
     */
    func isEquivalentSizeTo(otherView: UIView, precision: Int = 2) -> Bool {
        return bounds.size.isEquivalentTo(otherSize: otherView.bounds.size)
    }
    
    func isEquivalentSizeTo(_ rect: CGRect, precision: Int = 2) -> Bool {
        return bounds.size.isEquivalentTo(otherSize: rect.size)
    }
    
}
