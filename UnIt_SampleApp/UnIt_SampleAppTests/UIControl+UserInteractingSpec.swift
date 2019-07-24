import Nimble
import Quick
import UnIt
@testable import UnIt_SampleApp

class UIControlUserInteractingSpec: QuickSpec {
    override func spec() {
        var loadedVc: ActionViewController!
        
        describe("ViewController with user inputs") {
            beforeEach() {
                loadedVc = UIViewController.loadAndSetupViewControllerFromNib("ActionViewController", ActionViewController.self, Device.iPhone7Plus)
            }
            
            context("When the user taps the action button - simulating the user tapping a button") {
                beforeEach {
                    loadedVc.buttonSwitch.isOn = false
                    loadedVc.button.tap()
                }
                
                it("should enable the button switch") {
                    expect(loadedVc.buttonSwitch.isOn).to(beTrue())
                }
            }
        }
    }
}

