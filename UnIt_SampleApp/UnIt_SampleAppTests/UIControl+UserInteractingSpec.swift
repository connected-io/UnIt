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
                loadedVc.buttonSwitch.isOn = false
                loadedVc.button.isEnabled = true
                loadedVc.button.isHidden = false
            }
            
            context("When a tap is sent to the enabled and visible button") {
                it("should toggle the corresponding switch") {
                    expect { try loadedVc.button.tap() }.toNot(throwError())
                    expect(loadedVc.buttonSwitch.isOn).to(beTrue())
                }
            }
            
            context("When a tap is sent to a disabled button") {
                it("should throw") {
                    loadedVc.button.isEnabled = false
                    expect { try loadedVc.button.tap() }.to(throwError())
                }
            }
            
            context("When a tap is sent to a hidden button") {
                it("should throw") {
                    loadedVc.button.isHidden = true
                    expect { try loadedVc.button.tap() }.to(throwError())
                }
            }
            
            context("When a tap is sent to a zero-width button") {
                it("should throw") {
                    expect { try loadedVc.zeroWidthButton.tap() }.to(throwError())
                }
            }
        }
    }
}
