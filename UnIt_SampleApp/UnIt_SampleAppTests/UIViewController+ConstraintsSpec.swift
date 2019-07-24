import Nimble
import Quick
import UnIt
@testable import UnIt_SampleApp

class UIViewControllerConstraintsSpec: QuickSpec {
    override func spec() {
        var loadedVc: ConstraintBreakViewController!
        
        describe("View Controller with constraint breaks") {
            beforeEach {
                loadedVc = UIViewController.loadAndSetupViewControllerFromNib("ConstraintBreakViewController", ConstraintBreakViewController.self, Device.iPhone7, Bundle.main, shouldCaptureConstraintBreaks:  true)
            }
            
            context("When the view has finished laying out") {
                it("should show find all the conflicting constraints") {
                    expect(loadedVc.conflictingConstraints).toNot(beEmpty())
                    expect(loadedVc.conflictingConstraints.flatMap{ $0 }.count).to(equal(18))
                }
            }
            
            context("When the view has finished laying out and called again to test swizzling is only called once") {
                it("should show find all the conflicting constraints") {
                    expect(loadedVc.conflictingConstraints).toNot(beEmpty())
                    expect(loadedVc.conflictingConstraints.flatMap{ $0 }.count).to(equal(18))
                }
            }
        }
    }
}

