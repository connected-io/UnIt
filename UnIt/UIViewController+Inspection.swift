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
    
    /**
     Finds all the overlapped subviews within a **UIViewController's** view. Removes redundant overlaps so if A overlaps with B, but C which is a subview of A also overlaps, this function will only return the A and B overlap. Also, this function does not include overlaps from view to subviews since they will always overlap (i.e. if C is a subview of A, it is obvious that they overlap so the function will not include them).
     - parameters:
        - whitelist: an array of **UIView** tuples that should not be returned in the overlap dictionary.
     - returns: A dictionary with key: 2 overlappping subviews in a set and value: the area that the pair intersects at.
     */
    public func overlappingSubviews(whitelist: [(firstView: UIView, secondView: UIView)] = []) -> [Set<UIView>:CGRect] {
        return view.findOverlappingSiblingSubviews(whitelist: whitelist)
    }
}
