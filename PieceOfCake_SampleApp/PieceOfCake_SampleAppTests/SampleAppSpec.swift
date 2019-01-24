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
import PieceOfCake
@testable import PieceOfCake_SampleApp

class SampleAppSpec: QuickSpec {
    override func spec() {
        var subject : ViewController!
        var nibSubject : NibViewController!
        var actionSubject : ActionViewController!
        var overlapSubject : OverlapViewController!
        
        describe("ViewController from storyboard") {
            beforeEach() {
                subject = UIViewController.loadAndSetupViewControllerFromStoryboard("Main", Bundle.main, "ViewController") as? ViewController
            }

            it("should not be nil") {
                expect(subject).notTo(beNil())
                expect(subject.view).notTo(beNil())
            }

            it("should have a label that has 'Connected.'") {
                expect(subject.view.firstLabelPassing(with: "Connected.")).notTo(beNil())
            }
            
            it("should not have a label that has 'No text'") {
                expect(subject.view.firstLabelPassing(with: "No text")).to(beNil())
            }

            it("should have a label that has 'Montreal.' which is being set in viewDidAppear:") {
                expect(subject.view.firstLabelPassing(with: "Montreal.")).notTo(beNil())
            }
            
            it("should have a table view cell with text 'Alaska'") {
                expect(subject.view.firstVisibleTableViewCellPassing(with: "Alaska")).notTo(beNil())
            }
            
            it("should not have a table view cell with text 'Mississippi'") {
                expect(subject.view.firstVisibleTableViewCellPassing(with: "Mississippi")).to(beNil())
            }
            
            it("should have a collection view cell with 'Ontario'") {
                expect(subject.view.firstVisibleCollectionViewCellPassing(with: "Ontario")).notTo(beNil())
            }
            
            it("should not have a collection view cell with 'Newfoundland'") {
                expect(subject.view.firstVisibleCollectionViewCellPassing(with: "Newfoundland")).to(beNil())
            }
            
            it("should have a label with the text 'Left Stack Label' in a UIStackView") {
                expect(subject.view.firstLabelPassing(with: "Left Stack Label")).notTo(beNil())
            }
            
            it("should have a button with the text 'Right Stack Button' in a UIStackView") {
                expect(subject.view.firstButtonPassing(with: "Right Stack Button")).notTo(beNil())
            }
        }
        
        describe("ViewController from nib") {
            beforeEach() {
                nibSubject = UIViewController.loadAndSetupViewControllerFromNib("NibViewController", Bundle.main, NibViewController.self)
            }

            it("should not be nil") {
                expect(nibSubject).notTo(beNil())
                expect(nibSubject.view).notTo(beNil())
            }

            it("should have a label that has text: 'Top View Controller Label'") {
                expect(nibSubject.view.firstLabelPassing(with: "Top View Controller Label")).notTo(beNil())

            }

            it("should have a button that has text: 'Bottom View Controller Button'") {
                expect(nibSubject.view.firstButtonPassing(with: "Bottom View Controller Button")).notTo(beNil())

            }

            it("should not have a label that has text: 'No Label'") {
                expect(nibSubject.view.firstLabelPassing(with: "No Label")).to(beNil())

            }

            it("should have a collection view cell with 'Acre' which is a collection view cell inside a view controller that is in a container view") {
                expect(nibSubject.view.firstVisibleCollectionViewCellPassing(with: "Acre")).notTo(beNil())
            }
            
            it("should not have a collection view cell with 'Pernambuco' which is a collection view cell inside a view controller that is in a container view") {
                expect(nibSubject.view.firstVisibleCollectionViewCellPassing(with: "Pernambuco")).to(beNil())
            }
            
            it("should have a label with the text 'Left Stack Label' in a UIStackView") {
                expect(nibSubject.view.firstLabelPassing(with: "Left Stack Label")).notTo(beNil())
            }
            
            it("should have a button with the text 'Right Stack Button' in a UIStackView") {
                expect(nibSubject.view.firstButtonPassing(with: "Right Stack Button")).notTo(beNil())
            }
        }
        
        describe("ViewController with user inputs") {
            beforeEach() {
                actionSubject = UIViewController.loadAndSetupViewControllerFromNib("ActionViewController", Bundle.main, ActionViewController.self)
            }
            
            it("should not be nil") {
                expect(actionSubject).notTo(beNil())
                expect(actionSubject.view).notTo(beNil())
            }
            
            it("should have disabled switches") {
                expect(actionSubject.textFieldSwitch.isOn).to(beFalse())
                expect(actionSubject.buttonSwitch.isOn).to(beFalse())
            }
            
            it("should have 3 hidden buttons") {
                expect(actionSubject.firstHiddenButton.isTrulyVisible()).to(beFalse())
                expect(actionSubject.secondHiddenButton.isTrulyVisible()).to(beFalse())
                expect(actionSubject.buttonInHiddenView.isTrulyVisible()).to(beFalse())
            }
            
            context("When the user taps the action button - simulating the user tapping a button") {
                beforeEach {
                    actionSubject.buttonSwitch.isOn = false
                    actionSubject.button.tap()
                }
                
                it("should enable the button switch") {
                    expect(actionSubject.buttonSwitch.isOn).to(beTrue())
                }
            }
            
            context("When the user types into the text field - simulating the user typing into a textfield") {
                beforeEach {
                    actionSubject.textFieldSwitch.isOn = false
                    actionSubject.textField.type(with: "Typing this in")
                }
                
                it("should enable the text field switch which turns on when the textfield length > 0") {
                    expect(actionSubject.textFieldSwitch.isOn).to(beTrue())
                }
            }
            
            context("When the user types letters and numbers into the numeric text field") {
                beforeEach {
                    actionSubject.numericTextField.type(with: "1a2b3c")
                }
                
                it("should have '123' text") {
                    expect(actionSubject.numericTextField.text).to(be("123"))
                }
            }
            
            context("When the user pastes an invalid and a valid string into a numeric text field") {
                beforeEach {
                    actionSubject.numericTextField.paste(with: "1a2b3c")
                    actionSubject.numericTextField.paste(with: "12345")
                }
                
                it("should display only '12345' in the numeric text field") {
                    expect(actionSubject.numericTextField.text).to(be("12345"))
                }
            }
        }
        
        describe("View Controller with overlapping elements") {
            beforeEach {
                overlapSubject = UIViewController.loadAndSetupViewControllerFromNib("OverlapViewController", Bundle.main, OverlapViewController.self)
            }
            
            context("When two views are overlapped and are within subviews") {
                it("should be overlapped and return the intersected area") {
                    expect(overlapSubject.button.findOverlappedArea(with: overlapSubject.label)).to(equal(CGRect.init(x: 143.0, y: 51.0, width: 10.0, height: 7.0)))
                }
            }
            
            context("When a label is on top of a table view cell") {
                it("should be overlapped and return the intersected area") {
                    let cell = overlapSubject.tableView.visibleCells[0]
                    expect(cell.findOverlappedArea(with: overlapSubject.overlappedTableViewLabel)).to(equal(CGRect.init(x: 39.0, y: 230.0, width: 42.0, height: 6.0)))
                }
            }
            
            context("When 3 labels are side by side and only 2 overlaps by 1 pixel") {
                it("should only return the intersected area between the 2 labels giving a width of 1 px") {
                    expect(overlapSubject.redButton.findOverlappedArea(with: overlapSubject.blueLabel)).to(equal(CGRect.zero))
                    expect(overlapSubject.greenLabel.findOverlappedArea(with: overlapSubject.blueLabel)).to(equal(CGRect.init(x: 87.0, y: 466.0, width: 1.0, height: 21.0)))
                }
            }
            
            context("when an imageview in a subview overlaps 2 labels and a button") {
                it("should return the intersected area between the 2 labels and button") {
                    expect(overlapSubject.imageView.findOverlappedArea(with: overlapSubject.redButton)).to(equal(CGRect.init(x: 16.0, y: 478.0, width: 30.0, height: 13.0)))
                    expect(overlapSubject.imageView.findOverlappedArea(with: overlapSubject.blueLabel)).to(equal(CGRect.init(x: 46.0, y: 478.0, width: 42.0, height: 9.0)))
                    expect(overlapSubject.imageView.findOverlappedArea(with: overlapSubject.greenLabel)).to(equal(CGRect.init(x: 87.0, y: 478.0, width: 27.0, height: 9.0)))
                }
            }
        }
    }
}
