public extension UIView {
    /**
     Checks to see if a **UIView** is actually shown to the user. Checks to see isHidden, alpha,
     height and width and superview visibility.
     - Note: Taken from an Objective-C library called PivotalCoreKit: https://github.com/pivotal-legacy/PivotalCoreKit/blob/master/UIKit/SpecHelper/Extensions/UIControl%2BSpec.m
     */
    func isTrulyVisible() -> Bool {
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
            return superview.isTrulyVisible()
        }
        
        return true
    }
        
    /**
     Checks the view's subviews and identifies which ones are partially or entirely off-screen.
     - returns: An array of **UIView** that are partially/entirely not in the view's bounds.
     */
    func subviewsOutOfBounds() -> [UIView] {
        return views(ofType: UIView.self) { subview in
            let rect = self.findOverlappedArea(with: subview)
            return !self.sizesAreEquivalent(subview.frame.size, rect.size)
        }
    }
    
    /**
     Checks the view's subviews and identifies which ones are partially off-screen.
     - returns: An array of **UIView** that are partially not in the view's bounds.
     */
    func subviewsPartiallyOutOfBounds() -> [UIView] {
        return views(ofType: UIView.self) { subview in
            let rect = self.findOverlappedArea(with: subview)
            return self != subview && self.sizesAreEquivalent(subview.frame.size, rect.size) && rect.size != CGSize.zero
        }
    }
    
    /**
     Checks the view's subviews and identifies which ones are entirely off-screen.
     - returns: An array of **UIView** that are entirely not in the view's bounds.
     */
    func subviewsEntirelyOutOfBounds() -> [UIView] {
        return views(ofType: UIView.self) { subview in
            let rect = self.findOverlappedArea(with: subview)
            return self != subview && rect.size == CGSize.zero && subview.isTrulyVisible()
        }
    }
    
    /**
     This function makes sure that when comparing widths and heights that no precision error occurs by rounding to 2 decimal places. (i.e. 10.666667 != 10.67 even though it falls within an acceptable range).
     - parameters:
        - firstSize: a **CGSize** of the first view.
        - secondSize: a **CGSize** of the second view.
     - returns: A true/false on whether the 2 sizes are equivalent up to 2 decimal places.
    */
    private func sizesAreEquivalent(_ firstSize: CGSize, _ secondSize: CGSize) -> Bool {
        return firstSize.width.roundTo(decimalPlace: 2) == secondSize.width.roundTo(decimalPlace: 2) &&
               firstSize.height.roundTo(decimalPlace: 2) == secondSize.height.roundTo(decimalPlace: 2)
    }
}
