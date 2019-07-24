import Nimble
import Quick
import UnIt
@testable import UnIt_SampleApp

class UIViewControllerSetupSpec: QuickSpec {
    override func spec() {
        var vcFromNib : NibViewController!
        var vcFromStoryboard: ViewController!
        
        describe("ViewController from nib") {
            beforeEach() {
                vcFromNib = UIViewController.loadAndSetupViewControllerFromNib("NibViewController", NibViewController.self, Device.iPhoneXS)
            }
            
            it("should not be nil") {
                expect(vcFromNib).notTo(beNil())
                expect(vcFromNib.view).notTo(beNil())
            }
        }
        
        describe("ViewController from storyboard") {
            beforeEach() {
                vcFromStoryboard = UIViewController.loadAndSetupViewControllerFromStoryboard("Main", "ViewController", Device.iPhoneXSMax)
            }
            
            it("should not be nil") {
                expect(vcFromStoryboard).notTo(beNil())
                expect(vcFromStoryboard.view).notTo(beNil())
            }
        }
    }
}
