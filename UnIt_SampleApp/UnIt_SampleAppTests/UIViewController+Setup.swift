import Nimble
import Quick
import UnIt
@testable import UnIt_SampleApp

class UIViewControllerSetupSpec: QuickSpec {
    override func spec() {
        var vcFromNib : EmbeddingViewController!
        var vcFromStoryboard: StoryboardedViewController!
        
        describe("ViewController from nib") {
            beforeEach() {
                vcFromNib = UIViewController.loadAndSetupViewControllerFromNib("EmbeddingViewController", EmbeddingViewController.self, Device.iPhoneXS)
            }
            
            it("should not be nil") {
                expect(vcFromNib).notTo(beNil())
                expect(vcFromNib.view).notTo(beNil())
            }
        }
        
        describe("ViewController from storyboard") {
            beforeEach() {
                vcFromStoryboard = UIViewController.loadAndSetupViewControllerFromStoryboard("Main", "StoryboardedViewController", Device.iPhoneXSMax)
            }
            
            it("should not be nil") {
                expect(vcFromStoryboard).notTo(beNil())
                expect(vcFromStoryboard.view).notTo(beNil())
            }
        }
    }
}
