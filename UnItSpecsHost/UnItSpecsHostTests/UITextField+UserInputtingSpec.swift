import Nimble
import Quick
import UnIt
@testable import UnItSpecsHost

class UITextFieldUserInputtingSpec: QuickSpec {
    override func spec() {
        var loadedVc: ActionViewController!
        
        describe("ViewController with user inputs") {
            beforeEach() {
                loadedVc = UIViewController.loadAndSetupViewControllerFromNib("ActionViewController", ActionViewController.self, Device.iPhone7Plus)
            }
            
            it("should have disabled switches") {
                expect(loadedVc.textFieldSwitch.isOn).to(beFalse())
                expect(loadedVc.buttonSwitch.isOn).to(beFalse())
            }
            
            context("When the user types into the text field - simulating the user typing into a textfield") {
                beforeEach {
                    loadedVc.textFieldSwitch.isOn = false
                    loadedVc.textField.type(with: "Typing this in")
                }
                
                it("should enable the text field switch which turns on when the textfield length > 0") {
                    expect(loadedVc.textFieldSwitch.isOn).to(beTrue())
                }
            }
            
            context("When the user types letters and numbers into the numeric text field") {
                beforeEach {
                    loadedVc.numericTextField.type(with: "1a2b3c")
                }
                
                it("should have '123' text") {
                    expect(loadedVc.numericTextField.text).to(be("123"))
                }
            }
            
            context("When the user pastes an invalid and a valid string into a numeric text field") {
                beforeEach {
                    loadedVc.numericTextField.paste(with: "1a2b3c")
                    loadedVc.numericTextField.paste(with: "12345")
                }
                
                it("should display only '12345' in the numeric text field") {
                    expect(loadedVc.numericTextField.text).to(be("12345"))
                }
            }
        }
    }
}

