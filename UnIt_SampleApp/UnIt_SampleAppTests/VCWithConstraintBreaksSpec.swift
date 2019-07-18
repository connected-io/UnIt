//
//  VCWithConstraintBreaksSpec.swift
//  UnIt_SampleAppTests
//
//  Created by Amaan Khan on 2019-07-18.
//  Copyright © 2019 cl-dev. All rights reserved.
//

import Foundation
import Nimble
import Quick
import UnIt
@testable import UnIt_SampleApp

class VCWithConstraintBreaksSpec: QuickSpec {
    override func spec() {
        var constraintBreakSubject: ConstraintBreakViewController!
        
        describe("View Controller with constraint breaks") {
            beforeEach {
                constraintBreakSubject = UIViewController.loadAndSetupViewControllerFromNib("ConstraintBreakViewController", ConstraintBreakViewController.self, Device.iPhone7, Bundle.main, shouldCaptureConstraintBreaks:  true)
            }
            
            context("When the view has finished laying out") {
                it("should show find all the conflicting constraints") {
                    expect(constraintBreakSubject.conflictingConstraints).toNot(beEmpty())
                    expect(constraintBreakSubject.conflictingConstraints.flatMap{ $0 }.count).to(equal(18))
                }
            }
            
            context("When the view has finished laying out and called again to test swizzling is only called once") {
                it("should show find all the conflicting constraints") {
                    expect(constraintBreakSubject.conflictingConstraints).toNot(beEmpty())
                    expect(constraintBreakSubject.conflictingConstraints.flatMap{ $0 }.count).to(equal(18))
                }
            }
        }
    }
}

