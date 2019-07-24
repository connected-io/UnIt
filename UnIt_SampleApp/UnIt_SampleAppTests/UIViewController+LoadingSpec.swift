import Nimble
import Quick
import UnIt
@testable import UnIt_SampleApp

class UIViewControllerLoadingSpec: QuickSpec {
    override func spec() {
         describe("Loading") {

            describe("from nib") {
                var loadedVc : NibViewController!
                beforeEach {
                    loadedVc = nil
                }
                it("should load the view controller from a named nib") {
                    loadedVc = NibViewController.loadFromNib(named: "NibViewController")
                    expect(loadedVc).toNot(beNil())
                }
                it("should load the view controller from a nib based on name-of-class if a specific nib name is not supplied in argument") {
                    loadedVc = NibViewController.loadFromNib()
                    expect(loadedVc).toNot(beNil())
                }
            }
            
            describe("from storyboard") {
                var loadedVc: ViewController!
                beforeEach {
                    loadedVc = nil
                }
                it("should load view controller from a storyboard with the specified identifier") {
                    loadedVc = ViewController.loadFromStoryboard(named: "Main", withIdentifier: "ViewController")
                    expect(loadedVc).toNot(beNil())
                }
                it("should fail to load if view controller is not of specified type") {
                    expect {
                        loadedVc = ViewController.loadFromStoryboard(named: "Main", withIdentifier: "OtherViewController") }
                        .to(raiseException(named: "UIViewControllerLoadException"))
                }
                it("should load view controller from a storyboard using name-of-class as default identifier if identifier is not supplied in argument") {
                    loadedVc = ViewController.loadFromStoryboard(named: "Main")
                    expect(loadedVc).toNot(beNil())
                }
            }
        }
    }
}
