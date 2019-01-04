//
//  NibTopViewController.swift
//  pieceofcake
//
//  Created by cl-dev on 2019-01-03.
//  Copyright © 2019 cl-dev. All rights reserved.
//

import UIKit

class NibTopViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("nibTop: viewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NSLog("nibTop: viewWillAppear:")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NSLog("nibTop: viewDidAppear:")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NSLog("nibTop: viewWillDisappear:")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NSLog("nibTop: viewDidDisappear:")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        NSLog("nibTop: viewWillLayoutSubviews")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        NSLog("nibTop: viewDidLayoutSubviews")
    }

}
