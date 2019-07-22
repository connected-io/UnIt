import Foundation
import UIKit

public extension UIView {
    /**
     Returns the first subclass of **UIView** that passes a certain test defined by you
     - parameters:
     - type: The class that you want to filter on.
     - test: The closure that the generic and it's subviews check against.
     - returns: The first generic of your choice that passes your test.
     */
    func firstView<T: UIView>(ofType type: T.Type, passing test: (T) -> Bool) -> T? {
        return firstView { view in
            guard let typedView = view as? T else {
                return false
            }
            return test(typedView)
            } as? T
    }
    
    /**
     Returns the first **UIView** that passes a certain test defined by you. Implements a breadth-first-search, but does an early return when it finds the first element that passes the test.
     - parameters:
     - test: The closure that the view and it's subviews check against.
     - returns: The first view that passes the test.
     */
    func firstView(passing test: (UIView) -> Bool) -> UIView? {
        var queue: [UIView] = [self]
        while !queue.isEmpty {
            let nextView = queue.removeFirst()
            if test(nextView) {
                return nextView
            }
            queue.append(contentsOf: nextView.subviews)
        }
        return nil
    }
    
    /**
     Returns all subviews of a **UIView** of your choice that passes a certain test defined by you. Does a full breadth-first-search going through the view hierarchy. Useful if you want to check against multiple **UIView** subclasses.
     - parameters:
     - test: The closure that the view and it's subviews check against.
     - returns: An array of generics of your choice that subclasses **UIView**.
     */
    func views<T: UIView>(ofType type: T.Type, passing test: ((T) -> Bool)? = nil) -> [T] {
        var viewsPassingTest: [T] = []
        var queue: [UIView] = [self]
        while !queue.isEmpty {
            let nextView = queue.removeFirst()
            if let typedView = nextView as? T,
                test?(typedView) ?? true {
                viewsPassingTest.append(typedView)
            }
            queue.append(contentsOf: nextView.subviews)
        }
        return viewsPassingTest
    }
}
