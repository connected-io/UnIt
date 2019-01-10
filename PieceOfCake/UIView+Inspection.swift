//
//  UIView+Inspection.swift
//  PieceOfCake
//
//  Created by cl-dev on 2019-01-10.
//  Copyright © 2019 cl-dev. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    /**
     Checks to see if a **UIView** is actually shown to the user. Checks to see isHidden, alpha,
     height and width and superview visibility.
     */
    public func isTrulyVisible() -> Bool {
        if self.isHidden {
            return false
        }
        
        if self.alpha == 0 {
            return false
        }
        
        if self.frame.size.width == 0 || self.frame.size.height == 0 {
            return false
        }
        
        if let superview = self.superview {
            return superview.isTrulyVisible()
        }
        
        return true
    }
    
    /**
     Finds the overlapped area between a **UIView** and another **UIView**.
     - Parameters:
        - view: The view that you want to check the intersection against.
     - Returns: A **CGRect** of the intersection between the two views. If there is no intersection a CGRect.zero is returned.
     */
    public func findOverlappedArea(with view: UIView) -> CGRect {
        let convertedSelf = self.superview?.convert(self.frame, to: UIApplication.shared.keyWindow) ?? CGRect.zero
        let convertedView = view.superview?.convert(view.frame, to: UIApplication.shared.keyWindow) ?? CGRect.zero

        if convertedSelf.intersects(convertedView) {
            let intersection = convertedSelf.intersection(convertedView)
            return intersection
        } else {
            return CGRect.zero
        }
    }
}
