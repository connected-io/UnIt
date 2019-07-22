import XCTest

public extension UIControl {
    /**
     Simulates tapping on a **UIControl**. This works on **UIButton**, **UITableViewCell**, **UICollectionViewCell** and more.
     */
    func tap() {
        if (isHidden) {
            XCTFail("Control cannot be hidden.")
            return
        }
        if (!isEnabled) {
            XCTFail("Control cannot be disabled.")
            return
        }
        if (bounds.size.width == 0) {
            XCTFail("Control cannot have width of 0.")
            return
        }
        if (bounds.size.height == 0) {
            XCTFail("Control cannot have height of 0.")
            return
        }
        sendActions(for: .touchUpInside)
    }
}
