import Nimble
import Quick
import UnIt
@testable import UnItSpecsHost

class UILabelInspectingSpec: QuickSpec {
    override func spec() {
        var loadedVc: LabelViewController!
        
        describe("View Controller with untruncated and truncated labels") {
            beforeEach {
                loadedVc = UIViewController.loadFromNib(named: "LabelViewController")
                loadedVc.runViewLifecycle(for: .iPhone8)
            }
            
            context("When the view has finished laying out") {
                it("should show find all the conflicting constraints") {
                    expect(loadedVc.conflictingConstraints).to(beEmpty())
                }
            }
            
            context("when the labels are set") {
                it("should find the untruncated labels") {
                    expect(loadedVc.oneLineLabelNoTruncation.isTruncated).to(beFalse())
                    expect(loadedVc.twoLineLabelNoTruncation.isTruncated).to(beFalse())
                    expect(loadedVc.infiniteLineLabel.isTruncated).to(beFalse())
                }
                
                it("should find the truncated labels") {
                    expect(loadedVc.oneLineLabelWithTruncation.isTruncated).to(beTrue())
                    expect(loadedVc.oneLineLabelWithIncreasingFontToTruncate.isTruncated).to(beTrue())
                    expect(loadedVc.oneLineLabelThatSizeWillDecreaseToTruncate.isTruncated).to(beTrue())
                    expect(loadedVc.threeLineLabelWithTruncation.isTruncated).to(beTrue())
                }
                
                it("should determine the theoretical number of lines the label should have to look untruncated") {
                    expect(loadedVc.oneLineLabelNoTruncation.numberOfTheoreticalLines()).to(equal(1))
                    expect(loadedVc.oneLineLabelWithTruncation.numberOfTheoreticalLines()).to(equal(2))
                    expect(loadedVc.twoLineLabelNoTruncation.numberOfTheoreticalLines()).to(equal(2))
                    expect(loadedVc.oneLineLabelWithIncreasingFontToTruncate.numberOfTheoreticalLines()).to(equal(3))
                    expect(loadedVc.oneLineLabelThatSizeWillDecreaseToTruncate.numberOfTheoreticalLines()).to(equal(2))
                    expect(loadedVc.threeLineLabelWithTruncation.numberOfTheoreticalLines()).to(equal(5))
                }
            }
        }
    
        describe("View Controller with untruncated and truncated labels on the largest possible iPhone to test screen sizes") {
            beforeEach {
                loadedVc = UIViewController.loadFromNib(named: "LabelViewController")
                loadedVc.runViewLifecycle(for: .iPhoneXSMax)
            }
            
            context("when the labels are set") {
                it("should determine the theoretical number of lines the label should have to look untruncated") {
                    expect(loadedVc.threeLineLabelWithTruncation.numberOfTheoreticalLines()).to(equal(4))
                }
            }
        }
        
        describe("View Controller with untruncated and truncated labels on the smallest possible iPhone to test screen sizes") {
            beforeEach {
                loadedVc = UIViewController.loadFromNib(named: "LabelViewController")
                loadedVc.runViewLifecycle(for: .iPhoneSE)
            }
            
            context("when the labels are set") {
                it("should find the truncated labels") {
                    expect(loadedVc.oneLineLabelNoTruncation.isTruncated).to(beTrue())
                }
            }
        }
        
        describe("View Controller with a label that could be multilined") {
            context("when the screen size allows one line") {
                it("should not be multilined") {
                    loadedVc = UIViewController.loadFromNib(named: "LabelViewController")
                    loadedVc.runViewLifecycle(for: .iPhoneXSMax)
                    expect(loadedVc.shortInfiniteLabel.isMultilined).to(beFalse())
                    expect(loadedVc.shortInfiniteLabel.numberOfTheoreticalLines()).to(equal(1))
                }
            }
            
            context("when the screen size forces multiline") {
                it("should be multilined") {
                    loadedVc = UIViewController.loadFromNib(named: "LabelViewController")
                    loadedVc.runViewLifecycle(for: .iPhoneSE)
                    expect(loadedVc.shortInfiniteLabel.isMultilined).to(beTrue())
                    expect(loadedVc.shortInfiniteLabel.numberOfTheoreticalLines()).to(equal(2))
                }
            }
        }
    }
}

