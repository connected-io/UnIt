//
//  VCWithOverlappingElementsSpec.swift
//  UnIt_SampleAppTests
//
//  Created by Amaan Khan on 2019-07-18.
//  Copyright © 2019 cl-dev. All rights reserved.
//

import Foundation
import Nimble
import Quick
import UnIt
@testable import UnIt_SampleApp

class VCWithOverlappingElementsSpec: QuickSpec {
    override func spec() {
        var overlapSubject: OverlapViewController!
        
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
        
        describe("View Controller with sibling overlaps and various whitelist methods") {
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
    }
}

