import Foundation
import Nimble
import Quick
import UnIt
@testable import UnIt_SampleApp

class VCWithLabelTruncationSpec: QuickSpec {
    override func spec() {
        var labelSubject: LabelViewController!
        
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

