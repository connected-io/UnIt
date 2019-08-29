import Nimble
import Quick
import UnIt
@testable import UnItSpecsHost

class UIViewInspectingSpec: QuickSpec {
    override func spec() {
        var loadedVc: ActionViewController!
        
        describe("ViewController with user inputs") {
            beforeEach() {
                loadedVc = UIViewController.loadFromNib(named: "ActionViewController")
                loadedVc.runViewLifecycle(for: .iPhone7Plus)
            }
            
            it("should have 3 hidden buttons") {
                expect(loadedVc.firstHiddenButton.isTrulyVisible).to(beFalse())
                expect(loadedVc.secondHiddenButton.isTrulyVisible).to(beFalse())
                expect(loadedVc.buttonInHiddenView.isTrulyVisible).to(beFalse())
            }
        }
    }
}

