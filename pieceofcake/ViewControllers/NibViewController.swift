//
//  NibViewController.swift
//  pieceofcake
//
//  Created by cl-dev on 2019-01-03.
//  Copyright © 2019 cl-dev. All rights reserved.
//

import Foundation
import UIKit

class NibViewController: UIViewController {
    
    @IBOutlet weak var topContainerView: UIView!
    @IBOutlet weak var bottomContainerView: UIView!
    
    let topViewController = NibTopViewController.init(nibName: "NibTopViewController", bundle: Bundle.main)
    let bottomViewController = NibBottomViewController.init(nibName: "NibBottomViewController", bundle: Bundle.main)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("nib: viewDidLoad")
        embedViewControllers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NSLog("nib: viewWillAppear:")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NSLog("nib: viewDidAppear:")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NSLog("nib: viewWillDisappear:")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NSLog("nib: viewDidDisappear:")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        NSLog("nib: viewWillLayoutSubviews")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        NSLog("nib: viewDidLayoutSubviews")
    }
    
    // MARK: Setup
    private func embedViewControllers() {
        addChild(topViewController)
        topContainerView.addSubview(topViewController.view)
        topViewController.view.frame = topContainerView.bounds
        topViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        topViewController.didMove(toParent: self)
        
        addChild(bottomViewController)
        bottomContainerView.addSubview(bottomViewController.view)
        bottomViewController.view.frame = bottomContainerView.bounds
        bottomViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        bottomViewController.didMove(toParent: self)
    }

}
