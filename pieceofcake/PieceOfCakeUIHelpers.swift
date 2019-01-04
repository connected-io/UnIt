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
    /**
     Finds the first **UILabel** within the given **UIView** that exactly matches the given text.
     - parameters:
        - view: the view that is passed in order to search within its view hierarchy for the label.
        - text: the string that a label in the given view must match.
     - returns: The first **UILabel** found to match the text or nil if not.
     */
    static func firstLabelPassing(with view: UIView, text: String) -> UILabel?
    
    /**
     Finds the first **UIButton** within the given **UIView** that has the exact same title as the given text.
     - parameters:
        - view: the view that is passed in order to search within its view hierarchy for the button.
        - text: the string that a button title in the given view must match.
     - returns: The first **UIButton** found to match the text or nil if not.
     */
    static func firstButtonPassing(with view: UIView, text: String) -> UIButton?
    
    /**
     Finds the first **UITableViewCell** within the given **UIView** that has a **UILabel** that exactly matches the given text.
     - parameters:
        - view: the view that is passed in order to search within its view hierarchy for the table view cell.
        - text: the string that a label within a table view cell must match.
     - returns: The first **UITableViewCell** found to match the text or nil if not.
     */
    static func firstVisibleTableViewCellPassing(with view: UIView, text: String) -> UITableViewCell?
    
    /**
     Finds the first **UICollectionViewCell** within the given **UIView** that has a **UILabel** that exactly matches the given text.
     - parameters:
        - view: the view that is passed in order to search within its view hierarchy for the collection view cell.
        - text: the string that a label within a collection view cell must match.
     - returns: The first **UICollectionViewCell** found to match the text or nil if not.
     */
    static func firstVisibleCollectionViewCellPassing(with view: UIView, text: String) -> UICollectionViewCell?
}

protocol PieceOfCakeViewControllerSetupAndInstantiationProtocol {
    /**
     Creates a **UIViewController** or subclass from storyboard and also makes sure it's view lifecycle is ran according to UIKit.
     - parameters:
        - storyboardname: name of the storyboard. (i.e. For Main.storyboard you would put "Main").
        - bundle: the bundle where the storyboard exists.
        - identifier: the identifier of the view controller that exists inside your storyboard.
     - returns: Your custom view controller from storyboard.
     */
    static func loadAndSetupViewControllerFromStoryboard(_ storyboardName: String, _ bundle: Bundle, _ identifier: String) -> UIViewController?
    
    /**
     Creates a **UIViewController** or subclass from xib and also makes sure it's view lifecycle is ran according to UIKit.
     - parameters:
        - nibName: the name of the xib file. (i.e. For MyView.xib you would put "MyView").
        - bundle: the bundle where the xib file exists.
        - klass: the custom view controller class that you want to instantiate.
     - returns: your custom view controller from xib.
     */
    static func loadAndSetupViewControllerFromNib<T: UIViewController>(_ nibName: String, _ bundle: Bundle, _ klass: T.Type) -> T?
    
    /**
     Runs the view lifecycle on the view controller that is passed in to match UIKit. It will **roughly** follow the following view lifecycle:
        - viewDidLoad()
        - viewWillAppear(animated: Bool)
        - viewWillLayoutSubviews()
        - viewDidLayoutSubviews()
        - viewDidAppear(animated: Bool)
        - viewWillLayoutSubviews()
        - viewDidLayoutSubviews()
     */
    static func kickingUIKitFor(viewController: UIViewController?)
}

class PieceOfCakeUIHelpers {
    /**
     Returns all subviews of a **UIView** of your choice by recursively going through it's view hierarchy.
     - parameters:
        - view: The view that you want it's subviews for.
     - returns: A generic of your choice. (i.e. If you want all labels within a UIView you would write `let labels:[UILabel] = returnSubviewsFor(view: view)`).
     */
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
    static func firstLabelPassing(with view: UIView, text: String) -> UILabel? {
        let allLabels:[UILabel] = returnSubviewsFor(view: view)
        for label in allLabels {
            if (label.text == text) {
                return label
            }
        }
        return nil
    }
    
    static func firstButtonPassing(with view: UIView, text: String) -> UIButton? {
        let allButtons:[UIButton] = returnSubviewsFor(view: view)
        for button in allButtons {
            if (button.titleLabel?.text == text) {
                return button
            }
        }
        return nil
    }
    
    static func firstVisibleTableViewCellPassing(with view: UIView, text: String) -> UITableViewCell? {
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
    
    static func firstVisibleCollectionViewCellPassing(with view: UIView, text: String) -> UICollectionViewCell? {
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
