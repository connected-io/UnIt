import UIKit

public extension UIView {
    func subviewsWithDefaultAccessibility() -> [UIView] {
        // Is this possible?
        return []
    }
    
    func subviewsWithoutAccessibilityLabels() -> [UIView] {
        return subviews.filter{ $0.accessibilityLabel == nil }
    }
    
    func subviewsWithoutAccessibilityIdentifiers() -> [UIView] {
        return subviews.filter{ $0.accessibilityIdentifier == nil }
    }
    
    func subviewsWithoutAccessibilityHints() -> [UIView] {
        return subviews.filter{ $0.accessibilityHint == nil }
    }
    
    func subviewsWithoutAccessibilityValues() -> [UIView] {
        return subviews.filter{ $0.accessibilityValue == nil }
    }
    
    func subviewsWithoutAccessibilityTraits() -> [UIView] {
        return subviews.filter{ $0.accessibilityTraits.isEmpty } // Is this right?
    }
    
    func subviewsWithoutAccessibilityCustomActions() -> [UIView] {
        return subviews.filter{ view in
            if let actions = view.accessibilityCustomActions {
                return actions.isEmpty
            }
            return true
        }
    }
}
