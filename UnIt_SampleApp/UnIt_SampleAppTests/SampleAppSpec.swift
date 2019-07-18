import Foundation
import Nimble
import Quick
import UnIt
@testable import UnIt_SampleApp

class SampleAppSpec: QuickSpec {
    override func spec() {
        var overlapSubject : OverlapViewController!
        var labelSubject: LabelViewController!
        var constraintBreakSubject: ConstraintBreakViewController!
        var offscreenSubject: OffScreenViewController!

        describe("View Controller with overlapping elements") {
            beforeEach {
                overlapSubject = UIViewController.loadAndSetupViewControllerFromNib("OverlapViewController", OverlapViewController.self, Device.iPhone6)
            }

            context("When the view has finished laying out") {
                it("should show find all the conflicting constraints") {
                    expect(overlapSubject.conflictingConstraints).to(beEmpty())
                }
            }

            context("When two views are overlapped and are within subviews") {
                it("should be overlapped and return the intersected area") {
                    expect(overlapSubject.button.findOverlappedArea(with: overlapSubject.label)).to(equal(CGRect(x: 143.0, y: 51.0, width: 10.0, height: 7.0)))
                }
            }

            context("When a label is on top of a table view cell") {
                it("should be overlapped and return the intersected area") {
                    let cell = overlapSubject.tableView.visibleCells[0]
                    expect(cell.findOverlappedArea(with: overlapSubject.overlappedTableViewLabel)).to(equal(CGRect(x: 39.0, y: 230.0, width: 42.0, height: 6.0)))
                }
            }

            context("When 3 labels are side by side and only 2 overlaps by 1 pixel") {
                it("should only return the intersected area between the 2 labels giving a width of 1 px") {
                    expect(overlapSubject.redButton.findOverlappedArea(with: overlapSubject.blueLabel)).to(equal(CGRect.zero))
                    expect(overlapSubject.greenLabel.findOverlappedArea(with: overlapSubject.blueLabel)).to(equal(CGRect(x: 87.0, y: 466.0, width: 1.0, height: 21.0)))
                }
            }

            context("when an imageview in a subview overlaps 2 labels and a button") {
                it("should return the intersected area between the 2 labels and button") {
                    expect(overlapSubject.imageView.findOverlappedArea(with: overlapSubject.redButton)).to(equal(CGRect(x: 16.0, y: 478.0, width: 30.0, height: 13.0)))
                    expect(overlapSubject.imageView.findOverlappedArea(with: overlapSubject.blueLabel)).to(equal(CGRect(x: 46.0, y: 478.0, width: 42.0, height: 9.0)))
                    expect(overlapSubject.imageView.findOverlappedArea(with: overlapSubject.greenLabel)).to(equal(CGRect(x: 87.0, y: 478.0, width: 27.0, height: 9.0)))
                }
            }
        }
        
        describe("Testing a View Controller with sibling overlaps and various whitelist methods") {
            beforeEach {
                overlapSubject = UIViewController.loadAndSetupViewControllerFromNib("OverlapViewController", OverlapViewController.self, Device.iPhone6)
            }
            
            context("When the view has finished laying out") {                
                it("should find all the sibling overlapping views in the view controller") {
                    expect(overlapSubject.overlappingSubviews().count).to(equal(7))
                }
                
                it("should find all the sibiling overlapping views in the view controller after some elements become visible") {
                    overlapSubject.hiddenView.isHidden = false
                    expect(overlapSubject.overlappingSubviews().count).to(equal(8))
                    overlapSubject.alphaZeroView.alpha = 1
                    expect(overlapSubject.overlappingSubviews().count).to(equal(9))
                }
                
                it("should find all the sibling overlapping views in the view controller that are not in the pair view white list") {
                    let whiteListedOverlapViews = overlapSubject.overlappingSubviews(whiteList: [(overlapSubject.blueLabel, overlapSubject.royalBlueView), (overlapSubject.tableView, overlapSubject.overlappedTableViewLabel)])
                    expect(whiteListedOverlapViews.count).to(equal(5))
                }
                
                it("should find all the sibiling overlapping views in the view controller that are in the single view white list") {
                    let whiteListedOverlapViews = overlapSubject.overlappingSubviews(whiteList: [overlapSubject.royalBlueView, overlapSubject.royalBlueImageView])
                    expect(whiteListedOverlapViews.count).to(equal(3))
                }
                
                it("should find all the sibiling overlapping views in the view controller that are in the view tag white list") {
                    let whiteListedOverlapViews = overlapSubject.overlappingSubviews(whiteList: [11,12])
                    expect(whiteListedOverlapViews.count).to(equal(3))
                }
            }
        }
        
        describe("View Controller with constraint breaks") {
            beforeEach {
                constraintBreakSubject = UIViewController.loadAndSetupViewControllerFromNib("ConstraintBreakViewController", ConstraintBreakViewController.self, Device.iPhone7, Bundle.main, shouldCaptureConstraintBreaks:  true)
            }
            
            context("When the view has finished laying out") {
                it("should show find all the conflicting constraints") {
                    expect(constraintBreakSubject.conflictingConstraints).toNot(beEmpty())
                    expect(constraintBreakSubject.conflictingConstraints.flatMap{ $0 }.count).to(equal(18))
                }
            }
            
            context("When the view has finished laying out and called again to test swizzling is only called once") {
                it("should show find all the conflicting constraints") {
                    expect(constraintBreakSubject.conflictingConstraints).toNot(beEmpty())
                    expect(constraintBreakSubject.conflictingConstraints.flatMap{ $0 }.count).to(equal(18))
                }
            }
        }
        
        describe("View Controller with untruncated and truncated labels") {
            beforeEach {
                labelSubject = UIViewController.loadAndSetupViewControllerFromNib("LabelViewController", LabelViewController.self, Device.iPhone8)
            }

            context("When the view has finished laying out") {
                it("should show find all the conflicting constraints") {
                    expect(labelSubject.conflictingConstraints).to(beEmpty())
                }
            }

            context("when the labels are set") {
                it("should find the untruncated labels") {
                    expect(labelSubject.oneLineLabelNoTruncation.isTruncated).to(equal(false))
                    expect(labelSubject.twoLineLabelNoTruncation.isTruncated).to(equal(false))
                    expect(labelSubject.infiniteLineLabel.isTruncated).to(equal(false))
                }

                it("should find the truncated labels") {
                    expect(labelSubject.oneLineLabelWithTruncation.isTruncated).to(equal(true))
                    expect(labelSubject.oneLineLabelWithIncreasingFontToTruncate.isTruncated).to(equal(true))
                    expect(labelSubject.oneLineLabelThatSizeWillDecreaseToTruncate.isTruncated).to(equal(true))
                    expect(labelSubject.threeLineLabelWithTruncation.isTruncated).to(equal(true))
                }

                it("should determine the theoretical number of lines the label should have to look untruncated") {
                    expect(labelSubject.oneLineLabelNoTruncation.numberOfTheoreticalLines()).to(equal(1))
                    expect(labelSubject.oneLineLabelWithTruncation.numberOfTheoreticalLines()).to(equal(2))
                    expect(labelSubject.twoLineLabelNoTruncation.numberOfTheoreticalLines()).to(equal(2))
                    expect(labelSubject.oneLineLabelWithIncreasingFontToTruncate.numberOfTheoreticalLines()).to(equal(3))
                    expect(labelSubject.oneLineLabelThatSizeWillDecreaseToTruncate.numberOfTheoreticalLines()).to(equal(2))
                    expect(labelSubject.threeLineLabelWithTruncation.numberOfTheoreticalLines()).to(equal(5))
                }
            }
        }
        
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
        
        describe("View Controller with untruncated and truncated labels on the largest possible iPhone to test screen sizes") {
            beforeEach {
                labelSubject = UIViewController.loadAndSetupViewControllerFromNib("LabelViewController", LabelViewController.self, Device.iPhoneXSMax)
            }
            
            context("when the labels are set") {
                it("should determine the theoretical number of lines the label should have to look untruncated") {
                    expect(labelSubject.threeLineLabelWithTruncation.numberOfTheoreticalLines()).to(equal(4)) // same as line 227
                }
            }
        }
        
        describe("View Controller with untruncated and truncated labels on the smallest possible iPhone to test screen sizes") {
            beforeEach {
                labelSubject = UIViewController.loadAndSetupViewControllerFromNib("LabelViewController", LabelViewController.self, Device.iPhoneSE)
            }
            
            context("when the labels are set") {
                it("should find the truncated labels") {
                    expect(labelSubject.oneLineLabelNoTruncation.isTruncated).to(equal(true))
                }
            }
        }
    }
}
