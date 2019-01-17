import Foundation

extension UIViewController {
    /**
     Checks the view controller's subviews and identifies which ones are partially or entirely off-screen.
     - returns: An array of **UIView** that are partially cut-off or not even on the screen to the user.
     */
    public func viewsOffScreen() -> [UIView] {
        return view.subviewsOutOfBounds()
    }
    
    /**
     Checks the view controller's subviews and identifies which ones are partially off-screen.
     - returns: An array of **UIView** that are partially cut-off to the user.
     */
    public func viewsPartiallyOffScreen() -> [UIView] {
        return view.subviewsPartiallyOutOfBounds()
    }
    
    /**
     Checks the view controller's subviews and identifies which ones are entirely off-screen.
     - returns: An array of **UIView** that are entirely cut-off to the user.
     */
    public func viewsEntirelyOffScreen() -> [UIView] {
        return view.subviewsEntirelyOutOfBounds()
    }
}
