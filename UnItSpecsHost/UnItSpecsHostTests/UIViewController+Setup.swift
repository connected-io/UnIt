import Nimble
import Quick
import UnIt
@testable import UnItSpecsHost

class UIViewControllerSetupSpec: QuickSpec {
    override func spec() {
        var vcFromNib : EmbeddingViewController!
        var vcFromStoryboard: StoryboardedViewController!
        
        describe("ViewController from nib") {
            beforeEach() {
                vcFromNib = UIViewController.loadFromNib(named: "NibViewController")
                vcFromNib.runViewLifecycle(for: .iPhoneXS)
            }
            
            it("should not be nil") {
                expect(vcFromNib).notTo(beNil())
                expect(vcFromNib.view).notTo(beNil())
            }
            
            it("should have run its lifecycle") {
                expect(vcFromNib.lifecycle.contains(.didLoad)).to(beTrue())
                expect(vcFromNib.lifecycle.contains(.willAppear)).to(beTrue())
                expect(vcFromNib.lifecycle.contains(.willLayoutSubviews)).to(beTrue())
                expect(vcFromNib.lifecycle.contains(.didLayoutSubviews)).to(beTrue())
                expect(vcFromNib.lifecycle.contains(.didAppear)).to(beTrue())
            }
        }
        
        describe("ViewController from storyboard") {
            beforeEach() {
                vcFromStoryboard = UIViewController.loadFromStoryboard(named: "Main")
                vcFromStoryboard.runViewLifecycle(for: .iPhoneXSMax)
            }
            
            it("should not be nil") {
                expect(vcFromStoryboard).notTo(beNil())
                expect(vcFromStoryboard.view).notTo(beNil())
            }
        }
    }
}
