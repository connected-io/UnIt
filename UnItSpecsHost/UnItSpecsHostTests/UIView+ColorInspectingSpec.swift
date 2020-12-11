import Nimble
import Quick
import UnIt
@testable import UnItSpecsHost

public let almostRed = #colorLiteral(red: 0.9725490196, green: 0, blue: 0, alpha: 1) // sRGB:#F80000

class UIViewColorInspectingSpec: QuickSpec {
    override func spec() {
        var loadedVc: ColorViewController!
        
        describe("ViewController with colored UI items") {
            beforeEach() {
                loadedVc = UIViewController.loadFromNib(named: "ColorViewController")
                loadedVc.runViewLifecycle(for: .iPhoneXR)
            }
            
            it("Should have no subviews that aren't exactly red.") {
                let nonRedViews = loadedVc.view.subviewsWithoutColor(.red)
                expect(nonRedViews.count).to(equal(0))
            }
            
            it("Should have no subviews that aren't very close to red.") {
                let nonRedViews = loadedVc.view.subviewsWithoutApproximateColor(.red, margin: 0.1)
                expect(nonRedViews.count).to(equal(0))
            }
            
            it("Should have no subviews that aren't close to #F80000.") {
                let nonRedViews = loadedVc.view.subviewsWithoutApproximateColor(almostRed)
                expect(nonRedViews.count).to(equal(0))
            }
            
            it("Should have 6 subviews that aren't exactly #F80000.") {
                let nonBlueViews = loadedVc.view.subviewsWithoutColor(almostRed)
                expect(nonBlueViews.count).to(equal(6))
            }
            
            it("Should have 6 subviews that aren't near purple.") {
                let nonRedViews = loadedVc.view.subviewsWithoutApproximateColor(.purple)
                expect(nonRedViews.count).to(equal(6))
            }
        }
    }
}
