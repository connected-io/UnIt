//
//  UIViewController+PieceOfCakeExtensions.swift
//  pieceofcake
//
//  Created by cl-dev on 2019-01-08.
//  Copyright © 2019 cl-dev. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    /**
     Runs the view lifecycle on the view controller that is passed in to match UIKit. It will **roughly** follow the following view lifecycle:
     - viewDidLoad()
     - viewWillAppear(animated: Bool)
     - viewWillLayoutSubviews()
     - viewDidLayoutSubviews()
     - viewDidAppear(animated: Bool)
     - viewWillLayoutSubviews()
     - viewDidLayoutSubviews()
     - parameters:
     - viewController: the **UIViewController** that you want to run the view lifecycle against so it mirrors what UIKit does.
     */
    
    public func kickUIKit() {
        let _ = self.view
        self.viewWillAppear(false)
        self.view.layoutIfNeeded()
        self.viewDidAppear(false)
        self.view.layoutIfNeeded()
    }
    
    /**
     Creates a **UIViewController** or subclass from storyboard and also makes sure it's view lifecycle is ran according to UIKit.
     - parameters:
        - storyboardName: name of the storyboard. (i.e. For Main.storyboard you would put "Main").
        - bundle: the bundle where the storyboard exists.
        - identifier: the identifier of the view controller that exists inside your storyboard.
     - returns: Your custom view controller from storyboard.
     */
    static func loadAndSetupViewControllerFromStoryboard(_ storyboardName: String, _ bundle: Bundle, _ identifier: String) -> UIViewController? {
        let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier)
        viewController.kickUIKit()
        return viewController
    }
    
    /**
     Creates a **UIViewController** or subclass from xib and also makes sure it's view lifecycle is ran according to UIKit.
     - parameters:
        - nibName: the name of the xib file. (i.e. For MyView.xib you would put "MyView").
        - bundle: the bundle where the xib file exists.
        - klass: the custom view controller class that you want to instantiate.
     - returns: Your custom view controller from xib.
     */
    static func loadAndSetupViewControllerFromNib<T: UIViewController>(_ nibName: String, _ bundle: Bundle, _ klass: T.Type) -> T? {
        let viewController = klass.init(nibName: nibName, bundle: bundle)
        viewController.kickUIKit()
        return viewController
    }
}
