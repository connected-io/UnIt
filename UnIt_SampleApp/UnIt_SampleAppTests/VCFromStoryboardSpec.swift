//
//  VCFromStoryboardSpec.swift
//  UnIt_SampleAppTests
//
//  Created by Amaan on 2019-07-18.
//  Copyright © 2019 cl-dev. All rights reserved.
//

import Foundation
import Nimble
import Quick
import UnIt
@testable import UnIt_SampleApp

class VCFromStoryboardSpec: QuickSpec {
    override func spec() {
        var subject : ViewController!
        
        describe("ViewController from storyboard") {
            beforeEach() {
                subject = UIViewController.loadAndSetupViewControllerFromStoryboard("Main", "ViewController", Device.iPhoneXSMax)
            }
            
            it("should not be nil") {
                expect(subject).notTo(beNil())
                expect(subject.view).notTo(beNil())
            }
            
            it("should have a label that has 'Connected.'") {
                expect(subject.view.firstLabel(with: "Connected.")).notTo(beNil())
            }
            
            it("should not have a label that has 'No text'") {
                expect(subject.view.firstLabel(with: "No text")).to(beNil())
            }
            
            it("should have a label that has 'Montreal.' which is being set in viewDidAppear:") {
                expect(subject.view.firstLabel(with: "Montreal.")).notTo(beNil())
            }
            
            it("should have a table view cell with text 'Alaska'") {
                expect(subject.view.firstVisibleTableViewCell(with: "Alaska")).notTo(beNil())
            }
            
            it("should not have a table view cell with text 'Mississippi'") {
                expect(subject.view.firstVisibleTableViewCell(with: "Mississippi")).to(beNil())
            }
            
            it("should have a collection view cell with 'Ontario'") {
                expect(subject.view.firstVisibleCollectionViewCell(with: "Ontario")).notTo(beNil())
            }
            
            it("should not have a collection view cell with 'Newfoundland'") {
                expect(subject.view.firstVisibleCollectionViewCell(with: "Newfoundland")).to(beNil())
            }
            
            it("should have a label with the text 'Left Stack Label' in a UIStackView") {
                expect(subject.view.firstLabel(with: "Left Stack Label")).notTo(beNil())
            }
            
            it("should have a button with the text 'Right Stack Button' in a UIStackView") {
                expect(subject.view.firstButton(with: "Right Stack Button")).notTo(beNil())
            }
            
            context("when the tableview is scrolled to the bottom") {
                beforeEach {
                    subject.tableView.scrollToRow(at: NSIndexPath(row: 54, section: 0) as IndexPath, at: UITableView.ScrollPosition.bottom, animated: false)
                }
                
                it("should have a table view cell with text 'Wyoming'") {
                    expect(subject.view.firstVisibleTableViewCell(with: "Wyoming")).notTo(beNil())
                }
            }
        }
    }
}
