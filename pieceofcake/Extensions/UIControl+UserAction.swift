//
//  UIControl+UserAction.swift
//  pieceofcake
//
//  Created by cl-dev on 2019-01-08.
//  Copyright © 2019 cl-dev. All rights reserved.
//

import Foundation
import UIKit

extension UIControl {
    /**
     Simulates tapping on a **UIControl**. This works on **UIButton**, **UITableViewCell**, **UICollectionViewCell** and more.
     */
    public func tap() {
        //        if (self.isHidden) {
        //            throw PieceOfCakeError("Control cannot be hidden.")
        //        }
        //
        //        if (!self.isEnabled) {
        //            throw "Control cannot be disabled."
        //        }
        //
        //        if (self.bounds.size.width == 0) {
        //            throw "Control cannot have width of 0."
        //        }
        //
        //        if (self.bounds.size.height == 0) {
        //            throw "Control cannot have height of 0."
        //        }
        
        self.sendActions(for: .touchUpInside)
    }
}
