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
                vcWithOffscreenElements = UIViewController.loadFromNib(named: "OffScreenViewController")
                vcWithOffscreenElements.runViewLifecycle(for: .iPhoneXSMax)
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
                vcWithOverlappingElements = UIViewController.loadFromNib(named: "OverlapViewController")
                vcWithOverlappingElements.runViewLifecycle(for: .iPhone6)
            }
            
            context("When the view has finished laying out") {
                it("should show find all the conflicting constraints") {
                    expect(vcWithOverlappingElements.conflictingConstraints).to(beEmpty())
                }
            }
            
            context("When two views are overlapped and are within subviews") {
                it("should be overlapped and return the intersected area") {
                    let overlappingRect = vcWithOverlappingElements.button.findOverlappedArea(with: vcWithOverlappingElements.label)
                    let overlapWidth = overlappingRect.size.width.roundTo(decimalPlace: 0)
                    let overlapHeight = overlappingRect.size.height.roundTo(decimalPlace: 0)
                    expect(overlapWidth).to(equal(10))
                    expect(overlapHeight).to(equal(7))
                }
            }
            
            context("When a label is on top of a table view cell") {
                it("should be overlapped and return the intersected area") {
                    let cell = vcWithOverlappingElements.tableView.visibleCells[0]
                    let overlappingRect = cell.findOverlappedArea(with: vcWithOverlappingElements.overlappedTableViewLabel)
                    let overlapWidth = overlappingRect.size.width.roundTo(decimalPlace: 0)
                    let overlapHeight = overlappingRect.size.height.roundTo(decimalPlace: 0)
                    expect(overlapWidth).to(equal(42))
                    expect(overlapHeight).to(equal(21))
                }
            }
            
            context("When 3 labels are side by side and only 2 overlaps by 1 pixel") {
                it("should only return the intersected area between the 2 labels giving a width of 1 px") {
                    expect(vcWithOverlappingElements.redButton.findOverlappedArea(with: vcWithOverlappingElements.blueLabel)).to(equal(CGRect.zero))
                    
                    let overlappingRect = vcWithOverlappingElements.greenLabel.findOverlappedArea(with: vcWithOverlappingElements.blueLabel)
                    let overlapWidth = overlappingRect.size.width.roundTo(decimalPlace: 0)
                    let overlapHeight = overlappingRect.size.height.roundTo(decimalPlace: 0)
                    
                    expect(overlapWidth).to(equal(1))
                    expect(overlapHeight).to(equal(21))
                }
            }
            
            context("when an imageview in a subview overlaps 2 labels and a button") {
                it("should return the intersected area between the image view and red button") {
                    let overlappingRect = vcWithOverlappingElements.imageView.findOverlappedArea(with: vcWithOverlappingElements.redButton)
                    let overlappingWidth = overlappingRect.size.width.roundTo(decimalPlace: 0)
                    let overlappingHeight = overlappingRect.size.height.roundTo(decimalPlace: 0)
                    
                    expect(overlappingWidth).to(equal(30))
                    expect(overlappingHeight).to(equal(13))
                }
                
                it("should return the intersected area between the image view and blue label") {
                    let overlappingRect = vcWithOverlappingElements.imageView.findOverlappedArea(with: vcWithOverlappingElements.blueLabel)
                    let overlappingWidth = overlappingRect.size.width.roundTo(decimalPlace: 0)
                    let overlappingHeight = overlappingRect.size.height.roundTo(decimalPlace: 0)
                    
                    expect(overlappingWidth).to(equal(42))
                    expect(overlappingHeight).to(equal(9))
                }
                
                it("should return the intersected area between the image view and green label") {
                    let overlappingRect = vcWithOverlappingElements.imageView.findOverlappedArea(with: vcWithOverlappingElements.greenLabel)
                    let overlappingWidth = overlappingRect.size.width.roundTo(decimalPlace: 0)
                    let overlappingHeight = overlappingRect.size.height.roundTo(decimalPlace: 0)
                    
                    expect(overlappingWidth).to(equal(27))
                    expect(overlappingHeight).to(equal(9))
                }
            }
        }
        
        describe("View Controller with sibling overlaps and various whitelist methods") {
            beforeEach {
                vcWithOverlappingElements = UIViewController.loadFromNib(named: "OverlapViewController")
                vcWithOverlappingElements.runViewLifecycle(for: .iPhone6)
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

