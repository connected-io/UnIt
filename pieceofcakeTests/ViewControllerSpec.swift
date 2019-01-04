//
//  ViewControllerSpec.swift
//  pieceofcakeTests
//
//  Created by cl-dev on 2019-01-03.
//  Copyright © 2019 cl-dev. All rights reserved.
//

import Foundation
import Nimble
import Quick
@testable import pieceofcake

class ViewControllerSpec: QuickSpec {
    override func spec() {
        var subject : ViewController!
        var nibSubject : NibViewController!
        
        describe("VC from storyboard") {
            beforeEach() {
                subject = PieceOfCakeUIHelpers.loadAndSetupViewControllerFromStoryboard("Main", Bundle.main, "ViewController") as? ViewController
            }

            it("should not be nil") {
                expect(subject).notTo(beNil())
                expect(subject.view).notTo(beNil())
            }

            it("should have a label that has 'Connected.'") {
                expect(PieceOfCakeUIHelpers.firstLabelPassingWith(view: subject.view, text: "Connected.")).notTo(beNil())
            }

            it("should have a label that has 'Montreal.' which is being set in viewDidAppear:") {
                expect(PieceOfCakeUIHelpers.firstLabelPassingWith(view: subject.view, text: "Montreal.")).notTo(beNil())
            }
            
            it("should have a table view cell with text 'Alaska'") {
                expect(PieceOfCakeUIHelpers.firstVisibleTableViewCellPassingWith(view: subject.view, text: "Alaska")).notTo(beNil())
            }
            
            it("should not have a table view cell with text 'Mississippi'") {
                expect(PieceOfCakeUIHelpers.firstVisibleTableViewCellPassingWith(view: subject.view, text: "Mississippi")).to(beNil())
            }
        }
        
        describe("VC from nib") {
            beforeEach() {
                nibSubject = PieceOfCakeUIHelpers.loadAndSetupViewControllerFromNib("NibViewController", Bundle.main, NibViewController.self)
            }

            it("should not be nil") {
                expect(nibSubject).notTo(beNil())
                expect(nibSubject.view).notTo(beNil())
            }

            it("should have a label that has text: 'Top View Controller Label'") {
                expect(PieceOfCakeUIHelpers.firstLabelPassingWith(view: nibSubject.view, text: "Top View Controller Label")).notTo(beNil())
            }

            it("should have a button that has text: 'Bottom View Controller Button'") {
                expect(PieceOfCakeUIHelpers.firstButtonPassingWith(view: nibSubject.view, text: "Bottom View Controller Button")).notTo(beNil())
            }

            it("should not have a label that has text: 'No Label'") {
                expect(PieceOfCakeUIHelpers.firstLabelPassingWith(view: nibSubject.view, text: "No Label")).to(beNil())
            }
        }
    }
}
