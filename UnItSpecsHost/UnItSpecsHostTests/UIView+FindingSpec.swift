import Nimble
import Quick
import UnIt
@testable import UnItSpecsHost

class UIViewFindingSpec: QuickSpec {
    override func spec() {
        var loadedVc: StoryboardedViewController!
        
        describe("ViewController from storyboard") {
            beforeEach() {
                loadedVc = UIViewController.loadFromStoryboard(named: "Main", withIdentifier: "StoryboardedViewController")
                loadedVc.runViewLifecycle(for: .iPhoneXSMax)
            }
            
            it("should have not have a view that is hidden") {
                expect(loadedVc.view.firstView(passing: {
                    $0.isHidden == true
                })).to(beNil())
            }
            
            it("should have its first view which is a button, be the white button") {
                expect(loadedVc.view.firstView(passing: {
                    $0 is UIButton
                })?.backgroundColor).to(equal(UIColor.white))
            }
            
            it("should not have a view which is a button, with blue text color") {
                expect(loadedVc.view.firstView(ofType: UIButton.self, passing: {
                    $0.titleLabel?.textColor == .blue
                })?.titleLabel?.text).to(beNil())
            }
            
            it("should have its first view which is a button, with white text color, be the the 'Right Button' button") {
                expect(loadedVc.view.firstView(ofType: UIButton.self, passing: {
                    $0.titleLabel?.textColor == .white
                })?.titleLabel?.text).to(equal("Right Button"))
            }
            
            it("should have four views which are buttons") {
                expect(loadedVc.view.views(ofType: UIButton.self).count).to(equal(4))
            }
            
            it("should have no views which are switches") {
                expect(loadedVc.view.views(ofType: UISwitch.self).isEmpty).to(beTruthy())
            }
        }
    }
}


