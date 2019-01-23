//
//  UIView+PieceOfCakeExtensions.swift
//  pieceofcake
//
//  Created by cl-dev on 2019-01-08.
//  Copyright © 2019 cl-dev. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    /**
     Finds the first **UILabel** within the given **UIView** that exactly matches the given text.
     - parameters:
        - text: the string that a label in the given view must match.
     - returns: The first **UILabel** found to match the text or nil if not.
     */
    public func firstLabelPassing(with text: String) -> UILabel? {
        let allLabels:[UILabel] = self.returnViewHierarchy()
        for label in allLabels {
            if (label.text == text) {
                return label
            }
        }
        return nil
    }
    
    /**
     Finds the first **UIButton** within the given **UIView** that has the exact same title as the given text.
     - parameters:
        - text: the string that a button title in the given view must match.
     - returns: The first **UIButton** found to match the text or nil if not.
     */
    public func firstButtonPassing(with text: String) -> UIButton? {
        let allButtons:[UIButton] = self.returnViewHierarchy()
        for button in allButtons {
            if (button.titleLabel?.text == text) {
                return button
            }
        }
        return nil
    }
    
    /**
     Finds the first **UITableViewCell** within the given **UIView** that has a **UILabel** that exactly matches the given text.
     - parameters:
        - text: the string that a label within a table view cell must match.
     - returns: The first **UITableViewCell** found to match the text or nil if not.
     */
    public func firstVisibleTableViewCellPassing(with text: String) -> UITableViewCell? {
        let allTableViewCells:[UITableViewCell] = self.returnViewHierarchy()
        for tableViewCell in allTableViewCells {
            let labelsInTableViewCell:[UILabel] = tableViewCell.returnViewHierarchy()
            for label in labelsInTableViewCell {
                if (label.text == text) {
                    return tableViewCell
                }
            }
        }
        return nil
    }
    
    /**
     Finds the first **UICollectionViewCell** within the given **UIView** that has a **UILabel** that exactly matches the given text.
     - parameters:
        - text: the string that a label within a collection view cell must match.
     - returns: The first **UICollectionViewCell** found to match the text or nil if not.
     */
    public func firstVisibleCollectionViewCellPassing(with text: String) -> UICollectionViewCell? {
        let allCollectionViewCells:[UICollectionViewCell] = self.returnViewHierarchy()
        for collectionViewCell in allCollectionViewCells {
            let labelsInCollectionViewCell:[UILabel] = collectionViewCell.returnViewHierarchy()
            for label in labelsInCollectionViewCell {
                if (label.text == text) {
                    return collectionViewCell
                }
            }
        }
        return nil
    }
    
    /**
     Returns all subviews of a **UIView** of your choice by recursively going through it's view hierarchy.
     - returns: A generic of your choice. (i.e. If you want all labels within a UIView you would write `let labels:[UILabel] = returnSubviewsFor(view: view)`).
     */
    private func returnViewHierarchy<T: UIView>() -> [T] {
        var subviews = [T]()
        for subview in self.subviews {
            subviews += subview.returnViewHierarchy() as [T]
            
            if let subview = subview as? T {
                subviews.append(subview)
            }
        }
        return subviews
    }
}
