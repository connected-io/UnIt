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
        
        describe("ViewController from storyboard") {
            beforeEach() {
                subject = PieceOfCakeUIHelpers.loadAndSetupViewControllerFromStoryboard("Main", Bundle.main, "ViewController") as? ViewController
            }

            it("should not be nil") {
                expect(subject).notTo(beNil())
                expect(subject.view).notTo(beNil())
            }

            it("should have a label that has 'Connected.'") {
                expect(PieceOfCakeUIHelpers.firstLabelPassing(with: subject.view, text: "Connected.")).notTo(beNil())
            }
            
            it("should not have a label that has 'No text'") {
                expect(PieceOfCakeUIHelpers.firstLabelPassing(with: subject.view, text: "No text")).to(beNil())
            }

            it("should have a label that has 'Montreal.' which is being set in viewDidAppear:") {
                expect(PieceOfCakeUIHelpers.firstLabelPassing(with: subject.view, text: "Montreal.")).notTo(beNil())
            }
            
            it("should have a table view cell with text 'Alaska'") {
                expect(PieceOfCakeUIHelpers.firstVisibleTableViewCellPassing(with: subject.view, text: "Alaska")).notTo(beNil())
            }
            
            it("should not have a table view cell with text 'Mississippi'") {
                expect(PieceOfCakeUIHelpers.firstVisibleTableViewCellPassing(with: subject.view, text: "Mississippi")).to(beNil())
            }
            
            it("should have a collection view cell with 'Ontario'") {
                expect(PieceOfCakeUIHelpers.firstVisibleCollectionViewCellPassing(with: subject.view, text: "Ontario")).notTo(beNil())
            }
            
            it("should not have a collection view cell with 'Newfoundland'") {
                expect(PieceOfCakeUIHelpers.firstVisibleCollectionViewCellPassing(with: subject.view, text: "Newfoundland")).to(beNil())
            }
            
            it("should have a label with the text 'Left Stack Label' in a UIStackView") {
                expect(PieceOfCakeUIHelpers.firstLabelPassing(with: subject.view, text: "Left Stack Label")).notTo(beNil())
            }
            
            it("should have a button with the text 'Right Stack Button' in a UIStackView") {
                expect(PieceOfCakeUIHelpers.firstButtonPassing(with: subject.view, text: "Right Stack Button")).notTo(beNil())
            }
        }
        
        describe("ViewController from nib") {
            beforeEach() {
                nibSubject = PieceOfCakeUIHelpers.loadAndSetupViewControllerFromNib("NibViewController", Bundle.main, NibViewController.self)
            }

            it("should not be nil") {
                expect(nibSubject).notTo(beNil())
                expect(nibSubject.view).notTo(beNil())
            }

            it("should have a label that has text: 'Top View Controller Label'") {
                expect(PieceOfCakeUIHelpers.firstLabelPassing(with: nibSubject.view, text: "Top View Controller Label")).notTo(beNil())
            }

            it("should have a button that has text: 'Bottom View Controller Button'") {
                expect(PieceOfCakeUIHelpers.firstButtonPassing(with: nibSubject.view, text: "Bottom View Controller Button")).notTo(beNil())
            }

            it("should not have a label that has text: 'No Label'") {
                expect(PieceOfCakeUIHelpers.firstLabelPassing(with: nibSubject.view, text: "No Label")).to(beNil())
            }

            it("should have a collection view cell with 'Acre' which is a collection view cell inside a view controller that is in a container view") {
                expect(PieceOfCakeUIHelpers.firstVisibleCollectionViewCellPassing(with: nibSubject.view, text: "Acre")).notTo(beNil())
            }
            
            it("should not have a collection view cell with 'Pernambuco' which is a collection view cell inside a view controller that is in a container view") {
                expect(PieceOfCakeUIHelpers.firstVisibleCollectionViewCellPassing(with: nibSubject.view, text: "Pernambuco")).to(beNil())
            }
            
            it("should have a label with the text 'Left Stack Label' in a UIStackView") {
                expect(PieceOfCakeUIHelpers.firstLabelPassing(with: nibSubject.view, text: "Left Stack Label")).notTo(beNil())
            }
            
            it("should have a button with the text 'Right Stack Button' in a UIStackView") {
                expect(PieceOfCakeUIHelpers.firstButtonPassing(with: nibSubject.view, text: "Right Stack Button")).notTo(beNil())
            }
        }
    }
}
