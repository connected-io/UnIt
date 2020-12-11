import UIKit

public extension UIView {
    /// Compare if the view has one of its color properties set to the specified color.
    /// - Care needs to be taken around color profiles. If the color was specified in Interface Builder without choosing
    ///     the correct color profile in the color selector, then the comparison may fail.
    /// - Be aware of false positives when searching for colors that are identical to default colors.
    /// - Parameter color: The color to compare to.
    @objc func colorIsExactly(_ color: UIColor) -> Bool {
        if let backgroundColor = backgroundColor {
            return tintColor == color || backgroundColor == color
        } else {
            return tintColor == color
        }
    }
    
    /// Compare if the view has one of its color properties near to the specified color.
    /// - Be aware of false positives when searching for colors that are close to default colors.
    /// - Parameter color: The color to compare to.
    /// - Parameter margin: Determines how close the colors need to be to be considered a match. (Default 0.5)
    @objc func colorIsApproximately(_ color: UIColor, margin: CGFloat = 0.5) -> Bool {
        return (tintColor?.isNearTo(color: color, margin: margin) ?? false) || (backgroundColor?.isNearTo(color: color, margin: margin) ?? false)
    }
    
    /// Return an array of subviews that do not have any traits matching the specified color.
    /// - Care needs to be taken around color profiles. If the color was specified in Interface Builder without choosing
    ///     the correct color profile in the color selector, then the comparison may fail.
    /// - Be careful when searching for colors that are identical to default colors.
    /// - Parameter color: The color to compare to.
    func subviewsWithoutColor(_ color: UIColor) -> [UIView] {
        return subviews.filter{ !$0.colorIsExactly(color) }
    }
    
    /// Returns an array of subviews that do not have any traits that are close to the specified color.
    /// - Be careful when searching for colors that are close to default colors.
    /// - Parameter color: The color to compare to.
    /// - Parameter margin: Determines how close the colors need to be to be considered a match. (Default 0.5)
    func subviewsWithoutApproximateColor(_ color: UIColor, margin: CGFloat = 0.5) -> [UIView] {
        return subviews.filter{ !$0.colorIsApproximately(color, margin: margin) }
    }
}

public extension UIButton {
    override func colorIsExactly(_ color: UIColor) -> Bool {
        let buttonColors = [ titleColor(for: .normal),
                             titleColor(for: .selected),
                             titleColor(for: .highlighted),
                             titleShadowColor(for: .normal),
                             titleShadowColor(for: .selected),
                             titleShadowColor(for: .highlighted) ]
        for buttonColor in (buttonColors.compactMap{ $0 }) {
            if buttonColor == color {
                return true
            }
        }
        return super.colorIsExactly(color)
    }
    
    override func colorIsApproximately(_ color: UIColor, margin: CGFloat = 0.5) -> Bool {
        return super.colorIsApproximately(color, margin: margin)
            || (titleColor(for: .normal)?.isNearTo(color: color, margin: margin) ?? false)
            || (titleColor(for: .selected)?.isNearTo(color: color, margin: margin) ?? false)
            || (titleColor(for: .highlighted)?.isNearTo(color: color, margin: margin) ?? false)
            || (titleShadowColor(for: .normal)?.isNearTo(color: color, margin: margin) ?? false)
            || (titleShadowColor(for: .selected)?.isNearTo(color: color, margin: margin) ?? false)
            || (titleShadowColor(for: .highlighted)?.isNearTo(color: color, margin: margin) ?? false)
    }
}

public extension UILabel {
    override func colorIsExactly(_ color: UIColor) -> Bool {
        if textColor == color {
            return true
        }
        if let shadowColor = shadowColor, shadowColor == color {
            return true
        }
        if let highlightedTextColor = highlightedTextColor, highlightedTextColor == color {
            return true
        }
        return super.colorIsExactly(color)
    }
    
    override func colorIsApproximately(_ color: UIColor, margin: CGFloat = 0.5) -> Bool {
        return super.colorIsApproximately(color, margin: margin)
            || textColor.isNearTo(color: color, margin: margin)
            || (shadowColor?.isNearTo(color: color, margin: margin) ?? false)
            || (highlightedTextColor?.isNearTo(color: color, margin: margin) ?? false)
    }
}

public extension UITextField {
    override func colorIsExactly(_ color: UIColor) -> Bool {
        if let textColor = textColor, textColor == color {
            return true
        }
        return super.colorIsExactly(color)
    }
    
    override func colorIsApproximately(_ color: UIColor, margin: CGFloat = 0.5) -> Bool {
        return super.colorIsApproximately(color, margin: margin)
            || (textColor?.isNearTo(color: color, margin: margin) ?? false)
    }
}

public extension UISwitch {
    override func colorIsExactly(_ color: UIColor) -> Bool {
        if let onTintColor = onTintColor, onTintColor == color {
            return true
        }
        if let thumbTintColor = thumbTintColor, thumbTintColor == color {
            return true
        }
        return super.colorIsExactly(color)
    }
    
    override func colorIsApproximately(_ color: UIColor, margin: CGFloat = 0.5) -> Bool {
        return super.colorIsApproximately(color, margin: margin)
            || (onTintColor?.isNearTo(color: color, margin: margin) ?? false)
            || (thumbTintColor?.isNearTo(color: color, margin: margin) ?? false)
    }
}

public extension UISlider {
    override func colorIsExactly(_ color: UIColor) -> Bool {
        if let thumbTintColor = thumbTintColor, thumbTintColor == color {
            return true
        }
        return super.colorIsExactly(color)
    }
    
    override func colorIsApproximately(_ color: UIColor, margin: CGFloat = 0.5) -> Bool {
        return super.colorIsApproximately(color, margin: margin)
            || (thumbTintColor?.isNearTo(color: color, margin: margin) ?? false)
    }
}

public extension UIActivityIndicatorView {
    override func colorIsExactly(_ color: UIColor) -> Bool {
        return super.colorIsExactly(color) || self.color == color
    }
    
    override func colorIsApproximately(_ color: UIColor, margin: CGFloat = 0.5) -> Bool {
        return super.colorIsApproximately(color, margin: margin)
            || self.color.isNearTo(color: color, margin: margin)
    }
}
