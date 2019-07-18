//
//  VCWithUserInputsSpec.swift
//  UnIt_SampleAppTests
//
//  Created by Amaan on 2019-07-18.
//  Copyright © 2019 cl-dev. All rights reserved.
//

import Foundation
import Nimble
import Quick
import UnIt
@testable import UnIt_SampleApp

class VCWithUserInputsSpec: QuickSpec {
    override func spec() {
        var actionSubject: ActionViewController!
        
        describe("ViewController with user inputs") {
            beforeEach() {
                actionSubject = UIViewController.loadAndSetupViewControllerFromNib("ActionViewController", ActionViewController.self, Device.iPhone7Plus)
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
    }
}

