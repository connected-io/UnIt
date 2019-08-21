import XCTest

public enum UIControlUserInteractingError: Error {
    case controlIsHidden
    case controlIsDisabled
    case controlHasZeroDimension
}

public extension UIControl {
    /**
     Simulates tapping on a **UIControl**. This works on **UIButton**, **UITableViewCell**, **UICollectionViewCell** and more.
     */
    func tap() throws {
        if (isHidden) {
            throw UIControlUserInteractingError.controlIsHidden
        }
        if (!isEnabled) {
            throw UIControlUserInteractingError.controlIsDisabled
        }
        if (bounds.size.width == 0) {
            throw UIControlUserInteractingError.controlHasZeroDimension
        }
        if (bounds.size.height == 0) {
            throw UIControlUserInteractingError.controlHasZeroDimension
        }
        sendActions(for: .touchUpInside)
    }
}
