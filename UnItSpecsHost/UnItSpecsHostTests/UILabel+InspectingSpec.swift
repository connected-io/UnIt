import Nimble
import Quick
import UnIt
@testable import UnItSpecsHost

class UILabelInspectingSpec: QuickSpec {
    override func spec() {
        var loadedVc: LabelViewController!
        
        describe("View Controller with untruncated and truncated labels") {
            beforeEach {
                loadedVc = UIViewController.loadAndSetupViewControllerFromNib("LabelViewController", LabelViewController.self, Device.iPhone8)
            }
            
            context("When the view has finished laying out") {
                it("should show find all the conflicting constraints") {
                    expect(loadedVc.conflictingConstraints).to(beEmpty())
                }
            }
            
            context("when the labels are set") {
                it("should find the untruncated labels") {
                    expect(loadedVc.oneLineLabelNoTruncation.isTruncated).to(equal(false))
                    expect(loadedVc.twoLineLabelNoTruncation.isTruncated).to(equal(false))
                    expect(loadedVc.infiniteLineLabel.isTruncated).to(equal(false))
                }
                
                it("should find the truncated labels") {
                    expect(loadedVc.oneLineLabelWithTruncation.isTruncated).to(equal(true))
                    expect(loadedVc.oneLineLabelWithIncreasingFontToTruncate.isTruncated).to(equal(true))
                    expect(loadedVc.oneLineLabelThatSizeWillDecreaseToTruncate.isTruncated).to(equal(true))
                    expect(loadedVc.threeLineLabelWithTruncation.isTruncated).to(equal(true))
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
                loadedVc = UIViewController.loadAndSetupViewControllerFromNib("LabelViewController", LabelViewController.self, Device.iPhoneXSMax)
            }
            
            context("when the labels are set") {
                it("should determine the theoretical number of lines the label should have to look untruncated") {
                    expect(loadedVc.threeLineLabelWithTruncation.numberOfTheoreticalLines()).to(equal(4)) // same as line 227
                }
            }
        }
        
        describe("View Controller with untruncated and truncated labels on the smallest possible iPhone to test screen sizes") {
            beforeEach {
                loadedVc = UIViewController.loadAndSetupViewControllerFromNib("LabelViewController", LabelViewController.self, Device.iPhoneSE)
            }
            
            context("when the labels are set") {
                it("should find the truncated labels") {
                    expect(loadedVc.oneLineLabelNoTruncation.isTruncated).to(equal(true))
                }
            }
        }
    }
}

