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
        var actionSubject : ActionViewController!
        
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
    }
}
