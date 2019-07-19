import Foundation
import Nimble
import Quick
import UnIt
@testable import UnIt_SampleApp

class VCWithOffscreenViewsSpec: QuickSpec {
    override func spec() {
        var offscreenSubject: OffScreenViewController!
        
        describe("View Controller with views offscreen") {
            beforeEach {
                offscreenSubject = UIViewController.loadAndSetupViewControllerFromNib("OffScreenViewController", OffScreenViewController.self, Device.iPhone7)
            }
            
            context("When there are offscreen elements") {
                it("should find all the offscreen elements") {
                    expect(offscreenSubject.viewsOffScreen().count).to(equal(6))
                }
                
                it("should find all the partially offscreen elements") {
                    expect(offscreenSubject.viewsPartiallyOffScreen().count).to(equal(5))
                }
                
                it("should find all the entirely offscreen elements") {
                    expect(offscreenSubject.viewsEntirelyOffScreen().count).to(equal(1))
                }
            }
        }
    }
}

