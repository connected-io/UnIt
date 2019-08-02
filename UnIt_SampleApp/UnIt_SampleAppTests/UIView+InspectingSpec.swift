import Nimble
import Quick
import UnIt
@testable import UnIt_SampleApp

class UIViewInspectingSpec: QuickSpec {
    override func spec() {
        var view: UIView!
        
        describe("This view") {
            beforeEach() {
                view = nil
            }
            
            it("should be truly visible") {
                view  = UIView(frame: CGRect(x: 43.542, y: 12, width: 343.34, height: 534.32))
                expect(view.isTrulyVisible).to(beTruthy())
            }
            
            it("should not be truly visible given that its superview is not truly visible, even though it itself is") {
                view  = UIView(frame: CGRect(x: 43.542, y: 12, width: 343.34, height: 534.32))
                expect(view.isTrulyVisible).to(beTruthy())

                let superview = UIView(frame: CGRect(x: 43.542, y: 12, width: 0, height: 777))
                superview.addSubview(view)
                expect(view.isTrulyVisible).to(beFalsy())
            }
            
            it("should not be truly visible if it is hidden") {
                view  = UIView(frame: CGRect(x: 43.542, y: 12, width: 343.34, height: 534.32))
                view.isHidden = true
                expect(view.isTrulyVisible).to(beFalsy())
            }
            
            it("should not be truly visible if its alpha is 0") {
                view  = UIView(frame: CGRect(x: 43.542, y: 12, width: 343.34, height: 534.32))
                view.alpha = 0
                expect(view.isTrulyVisible).to(beFalsy())
            }
            
            it("should not be truly visible if its width is 0") {
                view  = UIView(frame: CGRect(x: 43.542, y: 12, width: 0, height: 534.32))
                expect(view.isTrulyVisible).to(beFalsy())
            }
            
            it("should not be truly visible if its height is 0") {
                view  = UIView(frame: CGRect(x: 43.542, y: 12, width: 343.34, height: 0))
                expect(view.isTrulyVisible).to(beFalsy())
            }
            
            it("should not be truly visible if its height is 0") {
                view  = UIView(frame: CGRect(x: 43.542, y: 12, width: 0, height: 0))
                expect(view.isTrulyVisible).to(beFalsy())
            }
        }
        
        describe("Comparing this view to other view") {
            var view: UIView!
            var otherView: UIView!
            
            beforeEach {
                view = nil
                otherView = nil
            }
            
            it("should return true if other view is the same width and height") {
                view = UIView(frame: CGRect(x: 43.542, y: 12, width: 343.34, height: 534.32))
                otherView = UIView(frame: CGRect(x: 43.542, y: 12, width: 343.34, height: 534.32))
                expect(view.isSizeRoughlyEqualTo(otherView: otherView)).to(beTruthy())
            }
            
            it("should be able to match view with zero height and width") {
                view = UIView(frame: CGRect(x: 43.542, y: 12, width: 0, height: 0))
                otherView = UIView(frame: CGRect(x: 43.542, y: 12, width: 0, height: 0))
                expect(view.isSizeRoughlyEqualTo(otherView: otherView)).to(beTruthy())
            }
            
            it("should be able to match views with 0 widths") {
                view = UIView(frame: CGRect(x: 43.542, y: 12, width: 0, height: 534.32))
                otherView = UIView(frame: CGRect(x: 43.542, y: 12, width: 0, height: 534.32))
                expect(view.isSizeRoughlyEqualTo(otherView: otherView)).to(beTruthy())
            }
            
            it("should be able to match views with 0 heights") {
                view = UIView(frame: CGRect(x: 43.542, y: 12, width: 343.34, height: 0))
                otherView = UIView(frame: CGRect(x: 43.542, y: 12, width: 343.34, height: 0))
                expect(view.isSizeRoughlyEqualTo(otherView: otherView)).to(beTruthy())
            }
        }
        
        describe("Comparing this view to a rectangle") {
            var view: UIView!
            var otherRect: CGRect!
            
            beforeEach {
                view = nil
                otherRect = nil
            }
            
            it("should return true if the rectangle is the same width and height") {
                view = UIView(frame: CGRect(x: 43.542, y: 12, width: 343.34, height: 534.32))
                otherRect = CGRect(x: 43.542, y: 12, width: 343.34, height: 534.32)
                expect(view.isSizeRoughlyEqualTo(rect: otherRect)).to(beTruthy())
            }
            
            it("should be able to match rectangle with zero height and width") {
                view = UIView(frame: CGRect(x: 43.542, y: 12, width: 0, height: 0))
                otherRect = CGRect(x: 43.542, y: 12, width: 0, height: 0)
                expect(view.isSizeRoughlyEqualTo(rect: otherRect)).to(beTruthy())
            }
            
            it("should be able to match rectangle with 0 width") {
                view = UIView(frame: CGRect(x: 43.542, y: 12, width: 0, height: 534.32))
                otherRect = CGRect(x: 43.542, y: 12, width: 0, height: 534.32)
                expect(view.isSizeRoughlyEqualTo(rect: otherRect)).to(beTruthy())
            }
            
            it("should be able to match rectangle with 0 height") {
                view = UIView(frame: CGRect(x: 43.542, y: 12, width: 343.34, height: 0))
                otherRect = CGRect(x: 43.542, y: 12, width: 343.34, height: 0)
                expect(view.isSizeRoughlyEqualTo(rect: otherRect)).to(beTruthy())
            }
        }
    }
}

