//
//  PieceOfCakeUIHelpers.swift
//  pieceofcake
//
//  Created by cl-dev on 2019-01-03.
//  Copyright © 2019 cl-dev. All rights reserved.
//

import Foundation
import UIKit

protocol PieceOfCakeAccessElementsProtocol {
    static func firstLabelPassingWith(view: UIView, text: String) -> UILabel?
    static func firstButtonPassingWith(view: UIView, text: String) -> UIButton?
    static func firstVisibleTableViewCellPassingWith(view: UIView, text: String) -> UITableViewCell?
    static func firstVisibleCollectionViewCellPassingWith(view: UIView, text: String) -> UICollectionViewCell?
}

protocol PieceOfCakeViewControllerSetupAndInstantiationProtocol {
    static func loadAndSetupViewControllerFromStoryboard(_ storyboardName: String, _ bundle: Bundle, _ identifier: String) -> UIViewController?
    static func loadAndSetupViewControllerFromNib<T: UIViewController>(_ nibName: String, _ bundle: Bundle, _ klass: T.Type) -> T?
}

class PieceOfCakeUIHelpers {
    private static func returnSubviewsFor<T: UIView>(view: UIView) -> [T] {
        var subviews = [T]()
        for subview in view.subviews {
            subviews += returnSubviewsFor(view: subview) as [T]
            
            if let subview = subview as? T {
                subviews.append(subview)
            }
        }
        return subviews
    }
}

extension PieceOfCakeUIHelpers : PieceOfCakeViewControllerSetupAndInstantiationProtocol {
    static func loadAndSetupViewControllerFromStoryboard(_ storyboardName: String, _ bundle: Bundle, _ identifier: String) -> UIViewController? {
        let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier)
        kickingUIKitFor(viewController: viewController)
        return viewController
    }
    
    static func loadAndSetupViewControllerFromNib<T: UIViewController>(_ nibName: String, _ bundle: Bundle, _ klass: T.Type) -> T? {
        let viewController = klass.init(nibName: nibName, bundle: bundle)
        kickingUIKitFor(viewController: viewController)
        return viewController
    }
    
    static func kickingUIKitFor(viewController: UIViewController?) {
        let _ = viewController?.view
        viewController?.viewWillAppear(false)
        viewController?.view.layoutIfNeeded()
        viewController?.viewDidAppear(false)
        viewController?.view.layoutIfNeeded()
    }
}

extension PieceOfCakeUIHelpers : PieceOfCakeAccessElementsProtocol {
    static func firstLabelPassingWith(view: UIView, text: String) -> UILabel? {
        let allLabels:[UILabel] = returnSubviewsFor(view: view)
        for label in allLabels {
            if (label.text == text) {
                return label
            }
        }
        return nil
    }
    
    static func firstButtonPassingWith(view: UIView, text: String) -> UIButton? {
        let allButtons:[UIButton] = returnSubviewsFor(view: view)
        for button in allButtons {
            if (button.titleLabel?.text == text) {
                return button
            }
        }
        return nil
    }
    
    static func firstVisibleTableViewCellPassingWith(view: UIView, text: String) -> UITableViewCell? {
        let allTableViewCells:[UITableViewCell] = returnSubviewsFor(view: view)
        for tableViewCell in allTableViewCells {
            let labelsInTableViewCell:[UILabel] = returnSubviewsFor(view: tableViewCell)
            for label in labelsInTableViewCell {
                if (label.text == text) {
                    return tableViewCell
                }
            }
        }
        return nil
    }
    
    static func firstVisibleCollectionViewCellPassingWith(view: UIView, text: String) -> UICollectionViewCell? {
        let allCollectionViewCells:[UICollectionViewCell] = returnSubviewsFor(view: view)
        for collectionViewCell in allCollectionViewCells {
            let labelsInCollectionViewCell:[UILabel] = returnSubviewsFor(view: collectionViewCell)
            for label in labelsInCollectionViewCell {
                if (label.text == text) {
                    return collectionViewCell
                }
            }
        }
        return nil
    }
}
