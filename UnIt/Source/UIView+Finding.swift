protocol TextTestable {
    var testableText: String { get }
}

public protocol ListItem { }
extension UICollectionViewCell: ListItem { }
extension UITableViewCell: ListItem { }

extension UIView : TextTestable {
    var testableText: String {
        if let label = self as? UILabel {
            return label.text ?? ""
        } else if let button = self as? UIButton {
            return button.titleLabel?.text ?? ""
        } else {
            return ""
        }
    }
}

public extension UIView {
    /**
     Finds the first **UILabel** within the given **UIView** that exactly matches the given text.
     - parameters:
        - text: the string that a label in the given view must match.
     - returns: The first **UILabel** found to match the text or nil if not.
     */
    func firstLabel(with text: String) -> UILabel? {
        return firstView(ofType: UILabel.self, passing: { $0.testableText == text } )
    }
    
    /**
     Finds the first **UIButton** within the given **UIView** that has the exact same title as the given text.
     - parameters:
        - text: the string that a button title in the given view must match.
     - returns: The first **UIButton** found to match the text or nil if not.
     */
    func firstButton(with title: String) -> UIButton? {
        return firstView(ofType: UIButton.self, passing: { $0.testableText == title } )
    }
    
    /**
     Finds the first **UITableViewCell** within the given **UIView** that has a **UILabel** that exactly matches the given text.
     - parameters:
        - text: the string that a label within a table view cell must match.
     - returns: The first **UITableViewCell** found to match the text or nil if not.
     */
    func firstVisibleTableViewCell(with text: String) -> UITableViewCell? {
        return views(ofType: UITableViewCell.self) { cell in
            return cell.firstLabel(with: text) != nil
        }.first
    }
    
    /**
     Finds the first **UICollectionViewCell** within the given **UIView** that has a **UILabel** that exactly matches the given text.
     - parameters:
        - text: the string that a label within a collection view cell must match.
     - returns: The first **UICollectionViewCell** found to match the text or nil if not.
     */
    func firstVisibleCollectionViewCell(with text: String) -> UICollectionViewCell? {
        return views(ofType: UICollectionViewCell.self) { cell in
            return cell.firstLabel(with: text) != nil
        }.first
    }
    
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
    
    func firstListItem(with text: String) -> ListItem? {
        return firstView { view in
            if view is ListItem {
                return view.firstLabel(with: text) != nil
            } else {
                return false
            }
        } as? ListItem
    }
    
    /**
     Returns the first **UIView** that passes a certain test defined by you. Implements a breadth-first-search, but does an early return when it finds the first element that passes the test.
     - parameters:
        - test: The closure that the view and it's subviews check against.
     - returns: The first view that passes the test.
     */
    private func firstView(passing test: (UIView) -> Bool) -> UIView? {
        var queue:[UIView] = [self]
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
    internal func views<T: UIView>(ofType type: T.Type, passing test: ((T) -> Bool)? = nil) -> [T] {
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
