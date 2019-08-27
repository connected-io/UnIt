protocol TextTestable {
    var testableText: String { get }
}

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
     Finds all **UILabels** within the given **UIView** that exactly match the given text.
     - parameters:
        - text: the string that labels in a given view must match.
     - returns: An array of labels that match the given string.
     */
    func labels(with text: String) -> [UILabel] {
        return views(ofType: UILabel.self) { label in
            return label.text == text
        }
    }
    
    /**
     
    */
    func buttons(with text: String) -> [UIButton] {
        return views(ofType: UIButton.self) { button in
            button.titleLabel?.text == text
        }
    }
    
    func tableViewCells(with text: String) -> [UITableViewCell] {
        return views(ofType: UITableViewCell.self) { cell in
            return cell.firstLabel(with: text) != nil
        }
    }
    
    func collectionViewCells(with text: String) -> [UICollectionViewCell] {
        return views(ofType: UICollectionViewCell.self) { cell in
            return cell.firstLabel(with: text) != nil
        }
    }
}
