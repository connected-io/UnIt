import Nimble
import Quick
import UnIt
@testable import UnItSpecsHost

class UIViewControllerInspectingSpec: QuickSpec {
    override func spec() {
        var vcWithOverlappingElements: OverlapViewController!
        var vcWithOffscreenElements: OffScreenViewController!
        
        describe("View Controller with views offscreen") {
            beforeEach {
                vcWithOffscreenElements = UIViewController.loadAndSetupViewControllerFromNib("OffScreenViewController", OffScreenViewController.self, Device.iPhone7)
            }
            
            context("When there are offscreen elements") {
                it("should find all the offscreen elements") {
                    expect(vcWithOffscreenElements.viewsOffScreen().count).to(equal(6))
                }
                
                it("should find all the partially offscreen elements") {
                    expect(vcWithOffscreenElements.viewsPartiallyOffScreen().count).to(equal(5))
                }
                
                it("should find all the entirely offscreen elements") {
                    expect(vcWithOffscreenElements.viewsEntirelyOffScreen().count).to(equal(1))
                }
            }
        }
        
        describe("View Controller with overlapping elements") {
            beforeEach {
                vcWithOverlappingElements = UIViewController.loadAndSetupViewControllerFromNib("OverlapViewController", OverlapViewController.self, Device.iPhone6)
            }
            
            context("When the view has finished laying out") {
                it("should show find all the conflicting constraints") {
                    expect(vcWithOverlappingElements.conflictingConstraints).to(beEmpty())
                }
            }
            
            context("When two views are overlapped and are within subviews") {
                it("should be overlapped and return the intersected area") {
                    expect(vcWithOverlappingElements.button.findOverlappedArea(with: vcWithOverlappingElements.label)).to(equal(CGRect(x: 143.0, y: 51.0, width: 10.0, height: 7.0)))
                }
            }
            
            context("When a label is on top of a table view cell") {
                it("should be overlapped and return the intersected area") {
                    let cell = vcWithOverlappingElements.tableView.visibleCells[0]
                    expect(cell.findOverlappedArea(with: vcWithOverlappingElements.overlappedTableViewLabel)).to(equal(CGRect(x: 39.0, y: 230.0, width: 42.0, height: 6.0)))
                }
            }
            
            context("When 3 labels are side by side and only 2 overlaps by 1 pixel") {
                it("should only return the intersected area between the 2 labels giving a width of 1 px") {
                    expect(vcWithOverlappingElements.redButton.findOverlappedArea(with: vcWithOverlappingElements.blueLabel)).to(equal(CGRect.zero))
                    expect(vcWithOverlappingElements.greenLabel.findOverlappedArea(with: vcWithOverlappingElements.blueLabel)).to(equal(CGRect(x: 87.0, y: 466.0, width: 1.0, height: 21.0)))
                }
            }
            
            context("when an imageview in a subview overlaps 2 labels and a button") {
                it("should return the intersected area between the 2 labels and button") {
                    expect(vcWithOverlappingElements.imageView.findOverlappedArea(with: vcWithOverlappingElements.redButton)).to(equal(CGRect(x: 16.0, y: 478.0, width: 30.0, height: 13.0)))
                    expect(vcWithOverlappingElements.imageView.findOverlappedArea(with: vcWithOverlappingElements.blueLabel)).to(equal(CGRect(x: 46.0, y: 478.0, width: 42.0, height: 9.0)))
                    expect(vcWithOverlappingElements.imageView.findOverlappedArea(with: vcWithOverlappingElements.greenLabel)).to(equal(CGRect(x: 87.0, y: 478.0, width: 27.0, height: 9.0)))
                }
            }
        }
        
        describe("View Controller with sibling overlaps and various whitelist methods") {
            beforeEach {
                vcWithOverlappingElements = UIViewController.loadAndSetupViewControllerFromNib("OverlapViewController", OverlapViewController.self, Device.iPhone6)
            }
            
            context("When the view has finished laying out") {
                it("should find all the sibling overlapping views in the view controller") {
                    expect(vcWithOverlappingElements.overlappingSubviews().count).to(equal(7))
                }
                
                it("should find all the sibiling overlapping views in the view controller after some elements become visible") {
                    vcWithOverlappingElements.hiddenView.isHidden = false
                    expect(vcWithOverlappingElements.overlappingSubviews().count).to(equal(8))
                    vcWithOverlappingElements.alphaZeroView.alpha = 1
                    expect(vcWithOverlappingElements.overlappingSubviews().count).to(equal(9))
                }
                
                it("should find all the sibling overlapping views in the view controller that are not in the pair view white list") {
                    let whiteListedOverlapViews = vcWithOverlappingElements.overlappingSubviews(whiteList: [(vcWithOverlappingElements.blueLabel, vcWithOverlappingElements.royalBlueView), (vcWithOverlappingElements.tableView, vcWithOverlappingElements.overlappedTableViewLabel)])
                    expect(whiteListedOverlapViews.count).to(equal(5))
                }
                
                it("should find all the sibiling overlapping views in the view controller that are in the single view white list") {
                    let whiteListedOverlapViews = vcWithOverlappingElements.overlappingSubviews(whiteList: [vcWithOverlappingElements.royalBlueView, vcWithOverlappingElements.royalBlueImageView])
                    expect(whiteListedOverlapViews.count).to(equal(3))
                }
                
                it("should find all the sibiling overlapping views in the view controller that are in the view tag white list") {
                    let whiteListedOverlapViews = vcWithOverlappingElements.overlappingSubviews(whiteList: [11,12])
                    expect(whiteListedOverlapViews.count).to(equal(3))
                }
            }
        }
    }
}
