public extension UIView {
    /**
     Finds all the **UILabels** that pass a given test within a **UIView**.
     - parameters:
        - test: A block that takes in a **UILabel** to pass a certain test.
     - returns: An array of **UILabels** that pass the given test.
     */
    func labelsPassing(test: @escaping (UILabel) -> Bool) -> [UILabel] {
        return views(ofType: UILabel.self, passing: test)
    }
    
    /**
     Finds all the **UIButtons** that pass a given test within a **UIView**.
     - parameters:
        - test: A block that takes in a **UIButton** to pass a certain test.
     - returns: An array of **UIButtons** that pass the given test.
     */
    func buttonsPassing(test: @escaping (UIButton) -> Bool) -> [UIButton] {
        return views(ofType: UIButton.self, passing: test)
    }
    
    /**
     Finds all the **UITableViewCells** that pass a given test within a **UIView**.
     - parameters:
        - test: A block that takes in a **UITableViewCell** to pass a certain test.
     - returns: An array of **UITableViewCells** that pass the given test.
     */
    func tableViewCellsPassing(test: @escaping (UITableViewCell) -> Bool) -> [UITableViewCell] {
        return views(ofType: UITableViewCell.self, passing: test)
    }
    
    /**
     Finds all the **UICollectionViewCells** that pass a given test within a **UIView**.
     - parameters:
        - test: A block that takes in a **UICollectionViewCell** to pass a certain test.
     - returns: An array of **UICollectionViewCells** that pass the given test.
     */
    func collectionViewCellPassing(test: @escaping (UICollectionViewCell) -> Bool) -> [UICollectionViewCell] {
        return views(ofType: UICollectionViewCell.self, passing: test)
    }
}
