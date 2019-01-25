import Foundation
import UIKit

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
     Finds the overlapped area between a **UIView** and another **UIView**.
     - Parameters:
        - view: The view that you want to check the intersection against.
     - Returns: A **CGRect** of the intersection between the two views. If there is no intersection a CGRect.zero is returned.
     */
    func findOverlappedArea(with view: UIView) -> CGRect {
        let convertedSelf = self.superview?.convert(self.frame, to: UIApplication.shared.keyWindow) ?? self.frame
        let convertedView = view.superview?.convert(view.frame, to: UIApplication.shared.keyWindow) ?? view.frame
        
        if convertedSelf.intersects(convertedView) {
            let intersection = convertedSelf.intersection(convertedView)
            return intersection
        } else {
            return CGRect.zero
        }
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
    
    private func sizesAreEquivalent(_ firstSize: CGSize, _ secondSize: CGSize) -> Bool {
        return firstSize.width.roundTo(decimalPlace: 2) == secondSize.width.roundTo(decimalPlace: 2) &&
               firstSize.height.roundTo(decimalPlace: 2) == secondSize.height.roundTo(decimalPlace: 2)
    }
}
