import Foundation
import UIKit
import XCTest

extension UIControl {
    /**
     Simulates tapping on a **UIControl**. This works on **UIButton**, **UITableViewCell**, **UICollectionViewCell** and more.
     */
    public func tap() {
        if (self.isHidden) {
            XCTFail("Control cannot be hidden.")
            return
        }
        
        if (!self.isEnabled) {
            XCTFail("Control cannot be disabled.")
            return
        }
        
        if (self.bounds.size.width == 0) {
            XCTFail("Control cannot have width of 0.")
            return
        }
        
        if (self.bounds.size.height == 0) {
            XCTFail("Control cannot have height of 0.")
            return
        }
        
        self.sendActions(for: .touchUpInside)
    }
}
