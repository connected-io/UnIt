public extension UIView {
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
     Finds all the overlapped subviews within a **UIView**. Removes redundant overlaps so if A overlaps with B, but C which is a subview of A also overlaps, this function will only return the A and B overlap. Also, this function does not include overlaps from view to subviews since they will always overlap (i.e. if C is a subview of A, it is obvious that they overlap so the function will not include them). Also ignores hidden, alpha = 0 views.
     - returns: A dictionary with key: 2 overlappping subviews in a set and value: the area that the pair intersects at.
     */
    func findOverlappingSiblingSubviews() -> [Set<UIView>:CGRect] {
        let subviews = views(ofType: UIView.self)
        return findOverlappingProvidedSubviews(subviews: subviews)
    }
    
    /**
     Finds all the overlapped subviews within a **UIView**. Removes redundant overlaps so if A overlaps with B, but C which is a subview of A also overlaps, this function will only return the A and B overlap. Also, this function does not include overlaps from view to subviews since they will always overlap (i.e. if C is a subview of A, it is obvious that they overlap so the function will not include them). Also ignores hidden, alpha = 0 views.
     - parameters:
        - whiteList: an array of **UIView** pair tuples that should not be returned in the overlap dictionary (example use case: a profile picture and an online indicator located in the top right corner of the profile is an intended overlap and should not be included.)
     - returns: A dictionary with key: 2 overlappping subviews in a set and value: the area that the pair intersects at.
     */
    func findOverlappingSiblingSubviews(whiteList: [(firstView: UIView, secondView: UIView)]) -> [Set<UIView>:CGRect] {
        let subviews = views(ofType: UIView.self)
        var pairOverlapAndAreaDictionary = findOverlappingProvidedSubviews(subviews: subviews)
        for whiteListPair in whiteList {
            let pairKeys = Array(pairOverlapAndAreaDictionary.keys)
            guard let overlapPair = pairKeys.filter({$0.contains(whiteListPair.firstView) && $0.contains(whiteListPair.secondView)}).first else {
                continue
            }
            pairOverlapAndAreaDictionary.removeValue(forKey: overlapPair)
        }
        return pairOverlapAndAreaDictionary
    }
    
    /**
     Finds all the overlapped subviews within a **UIView**. Removes redundant overlaps so if A overlaps with B, but C which is a subview of A also overlaps, this function will only return the A and B overlap. Also, this function does not include overlaps from view to subviews since they will always overlap (i.e. if C is a subview of A, it is obvious that they overlap so the function will not include them). Also ignores hidden, alpha = 0 views.
     - parameters:
        - whiteList: an array of **UIView** that should not be present at all in the returned overlap dictionary (example use case: a floating plus button in the bottom right hand corner as the user scrolls through a list (Google loves doing this in their apps - gmail, drive).)
     - returns: A dictionary with key: 2 overlappping subviews in a set and value: the area that the pair intersects at.
     */
    func findOverlappingSiblingSubviews(whiteList: [UIView]) -> [Set<UIView>:CGRect] {
        let subviews = views(ofType: UIView.self).filter{ !whiteList.contains($0) }
        return findOverlappingProvidedSubviews(subviews: subviews)
    }
    
    /**
     Finds all the overlapped subviews within a **UIView**. Removes redundant overlaps so if A overlaps with B, but C which is a subview of A also overlaps, this function will only return the A and B overlap. Also, this function does not include overlaps from view to subviews since they will always overlap (i.e. if C is a subview of A, it is obvious that they overlap so the function will not include them). Also ignores hidden, alpha = 0 views.
     - parameters:
        - whiteList: an array of **UIView** that should not be present at all in the returned overlap dictionary (example use case: when you want to include views within a **UITableViewCell** or **UICollectionViewCell**.)
     - returns: A dictionary with key: 2 overlappping subviews in a set and value: the area that the pair intersects at.
     */
    func findOverlappingSiblingSubviews(whiteList: [Int]) -> [Set<UIView>:CGRect] {
        let subviews = views(ofType: UIView.self).filter{ !whiteList.contains($0.tag) }
        return findOverlappingProvidedSubviews(subviews: subviews)
    }
    
    /**
     Finds all the overlapped subviews within a **UIView**. Removes redundant overlaps so if A overlaps with B, but C which is a subview of A also overlaps, this function will only return the A and B overlap. Also, this function does not include overlaps from view to subviews since they will always overlap (i.e. if C is a subview of A, it is obvious that they overlap so the function will not include them).
     - Returns: A dictionary with key: 2 overlappping subviews in a set and value: the area that the pair intersects at.
     */
    private func findOverlappingProvidedSubviews(subviews: [UIView]) -> [Set<UIView>:CGRect] {
        var overlapDictionary = [UIView:Set<UIView>]()
        let subviews = subviews.filter{ $0 != self && !$0.isScrollIndicator() && $0.isTrulyVisible }
        
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
        return pairOverlapAndAreaDictionary
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
}
