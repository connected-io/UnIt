import Foundation
import Nimble
import Quick
import UnIt
@testable import UnIt_SampleApp

class UIViewInspectingSpec: QuickSpec {
    override func spec() {
        var loadedVc: ActionViewController!
        
        describe("ViewController with user inputs") {
            beforeEach() {
                loadedVc = UIViewController.loadAndSetupViewControllerFromNib("ActionViewController", ActionViewController.self, Device.iPhone7Plus)
            }
            
            it("should have 3 hidden buttons") {
                expect(loadedVc.firstHiddenButton.isTrulyVisible).to(beFalse())
                expect(loadedVc.secondHiddenButton.isTrulyVisible).to(beFalse())
                expect(loadedVc.buttonInHiddenView.isTrulyVisible).to(beFalse())
            }
        }
    }
}

