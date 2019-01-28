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
     Finds all the overlapped subviews within a **UIView**. Removes redundant overlaps so if A overlaps with B, but C which is a subview of A also overlaps, this function will only return the A and B overlap. Also, this function does not include overlaps from view to subviews since they will always overlap (i.e. if C is a subview of A, it is obvious that they overlap so the function will not include them).
     - Parameters:
        - whitelist: an array of **UIView** tuples that should not be returned in the overlap dictionary.
     - Returns: A dictionary with key: 2 overlappping subviews in a set and value: the area that the pair intersects at.
     */
    public func findOverlappingSiblingSubviews(whitelist: [(firstView: UIView, secondView: UIView)] = []) -> [Set<UIView>:CGRect]{
        var overlapDictionary = [UIView:Set<UIView>]()
        let subviews = views(ofType: UIView.self).filter{ $0 != self && !$0.isScrollIndicator() }
        
        // Put all the subviews in a hash table and their overlapping views that are not subviews.
        for subject in subviews {
            let otherSubviewsThatOverlap = subject.filterOutSubviews(from: subviews).filter{ $0 != subject && $0.findOverlappedArea(with: subject) != CGRect.zero }
            if otherSubviewsThatOverlap.count > 0 {
                overlapDictionary[subject] = Set(otherSubviewsThatOverlap)
            }
        }
        
        // Remove overlapping views that are a parent of a subview.
        // i.e. if B is a subview of A, B technically overlaps with A. Remove A overlap from B.
        for (keyValue, overlappingViews) in overlapDictionary {
            for overlappingView in overlappingViews {
                if keyValue.isDescendant(of: overlappingView) {
                    overlapDictionary[keyValue]?.remove(overlappingView)
                }
            }
            if (overlapDictionary[keyValue]?.count == 0) {
                overlapDictionary.removeValue(forKey: keyValue)
            }
        }
        
        // If a view's ancestor also overlaps with that view's overlaps, the ancestor receives priority and the view removes it's overlap.
        // i.e. if B is a subview of A and both A and B overlap with C, remove C overlap from B, since A receives priority.
        let keys = Array(overlapDictionary.keys)
        for overlapView in keys {
            let ancestors = keys.filter{ overlapView.isDescendant(of: $0) && $0 != overlapView}
            for ancestor in ancestors {
                let commonOverlaps = overlapDictionary[ancestor]?.intersection(overlapDictionary[overlapView]!)
                overlapDictionary[overlapView]?.subtract(commonOverlaps ?? [])
            }
            if (overlapDictionary[overlapView]?.count == 0) {
                overlapDictionary.removeValue(forKey: overlapView)
            }
        }
        
        // If a view overlaps with multiple views, but they are some views that are subviews of others only retain overlaps with the parent views.
        // i.e. if A overlaps with B, C, D and E and C and D are subviews of B, A then overlaps with only B and E.
        for (keyValue, overlappingViews) in overlapDictionary {
            var childViewsToRemove:[UIView] = []
            for overlappingView in overlappingViews {
                childViewsToRemove.append(contentsOf: overlappingView.childviews())
            }
            overlapDictionary[keyValue]?.subtract(childViewsToRemove)
        }
        
        // Remove overlap duplicates where 2 views that overlap each other both state the overlap. Only one is needed.
        // i.e. if A overlaps B and B overlaps A, only 1 is needed so A overlaps B.
        for (keyView, overlappingViews) in overlapDictionary {
            for overlappingView in overlappingViews {
                if (overlapDictionary[overlappingView]?.contains(keyView) ?? false) {
                    overlapDictionary[keyView]?.remove(overlappingView)
                }
            }
            if (overlapDictionary[keyView]?.count == 0) {
                overlapDictionary.removeValue(forKey: keyView)
            }
        }
        
        // The overlap dictionary is complete, so a new dictionary where each key is a pair of overlapping views and the value is the area of the overlap is created here.
        var pairOverlapAndAreaDictionary = [Set<UIView>:CGRect]()
        for (keyView, overlapppingViews) in overlapDictionary {
            for overlappingView in overlapppingViews {
                let overlapPair:Set = [keyView, overlappingView]
                let overlappedArea = keyView.findOverlappedArea(with: overlappingView)
                pairOverlapAndAreaDictionary[overlapPair] = overlappedArea
            }
        }
        
        // Remove keys that are in the whitelist passed into the function.
        for whiteListPair in whitelist {
            let pairKeys = Array(pairOverlapAndAreaDictionary.keys)
            guard let overlapPair = pairKeys.filter({$0.contains(whiteListPair.firstView) && $0.contains(whiteListPair.secondView)}).first else {
                continue
            }
            pairOverlapAndAreaDictionary.removeValue(forKey: overlapPair)
        }
        
        return pairOverlapAndAreaDictionary
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
     Given an array of views, filter that array to not include any of the view's subviews.
     - parameters:
        - otherViews: an array of **UIView** to filter out your subviews against.
     - returns: A filtered array not including the view's subviews.
     */
    private func filterOutSubviews(from otherViews:[UIView]) -> [UIView] {
        return otherViews.filter{ !self.childviews().contains($0) }
    }
    
    /**
     Returns all the children of the given view.
     - returns: An array of **UIView** that are the children of the given view.
     */
    private func childviews() -> [UIView] {
        return self.views(ofType: UIView.self) { childView in
            return childView != self
        }
    }
    
    /**
     Turns out that the scroll indicators on a **UIScrollView** (**UITableView** and **UICollectionView**) included are actually 2 **UIImageViews** for both horizontal and vertical scrolling.
     - returns: A true/false value on whether the view is a scroll indicator.
     */
    private func isScrollIndicator() -> Bool {
        return self is UIImageView && self.superview is UIScrollView
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
