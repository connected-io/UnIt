import Foundation
import Nimble
import Quick
import UnIt
@testable import UnIt_SampleApp

class UIViewTextBasedFindingSpec: QuickSpec {
    override func spec() {
        var vcFromStoryboard: ViewController!
        var vcFromNib: NibViewController!
        
        describe("ViewController from storyboard") {
            beforeEach() {
                vcFromStoryboard = UIViewController.loadAndSetupViewControllerFromStoryboard("Main", "ViewController", Device.iPhoneXSMax)
            }
            
            it("should have a label that has 'Connected.'") {
                expect(vcFromStoryboard.view.firstLabel(with: "Connected.")).notTo(beNil())
            }
            
            it("should not have a label that has 'No text'") {
                expect(vcFromStoryboard.view.firstLabel(with: "No text")).to(beNil())
            }
            
            it("should have a label that has 'Montreal.' which is being set in viewDidAppear:") {
                expect(vcFromStoryboard.view.firstLabel(with: "Montreal.")).notTo(beNil())
            }
            
            it("should have a table view cell with text 'Alaska'") {
                expect(vcFromStoryboard.view.firstVisibleTableViewCell(with: "Alaska")).notTo(beNil())
            }
            
            it("should not have a table view cell with text 'Mississippi'") {
                expect(vcFromStoryboard.view.firstVisibleTableViewCell(with: "Mississippi")).to(beNil())
            }
            
            it("should have a collection view cell with 'Ontario'") {
                expect(vcFromStoryboard.view.firstVisibleCollectionViewCell(with: "Ontario")).notTo(beNil())
            }
            
            it("should not have a collection view cell with 'Newfoundland'") {
                expect(vcFromStoryboard.view.firstVisibleCollectionViewCell(with: "Newfoundland")).to(beNil())
            }
            
            it("should have a label with the text 'Left Stack Label' in a UIStackView") {
                expect(vcFromStoryboard.view.firstLabel(with: "Left Stack Label")).notTo(beNil())
            }
            
            it("should have a button with the text 'Right Stack Button' in a UIStackView") {
                expect(vcFromStoryboard.view.firstButton(with: "Right Stack Button")).notTo(beNil())
            }
            
            context("when the tableview is scrolled to the bottom") {
                beforeEach {
                    vcFromStoryboard.tableView.scrollToRow(at: NSIndexPath(row: 54, section: 0) as IndexPath, at: UITableView.ScrollPosition.bottom, animated: false)
                }
                
                it("should have a table view cell with text 'Wyoming'") {
                    expect(vcFromStoryboard.view.firstVisibleTableViewCell(with: "Wyoming")).notTo(beNil())
                }
            }
        }
        
        describe("ViewController from nib") {
            beforeEach() {
                vcFromNib = UIViewController.loadAndSetupViewControllerFromNib("NibViewController", NibViewController.self, Device.iPhoneXS)
            }
            
            it("should have a label that has text: 'Top View Controller Label'") {
                expect(vcFromNib.view.firstLabel(with: "Top View Controller Label")).notTo(beNil())
            }
            
            it("should have a button that has text: 'Bottom View Controller Button'") {
                expect(vcFromNib.view.firstButton(with: "Bottom View Controller Button")).notTo(beNil())
            }
            
            it("should not have a label that has text: 'No Label'") {
                expect(vcFromNib.view.firstLabel(with: "No Label")).to(beNil())
            }
            
            it("should have a collection view cell with 'Acre' which is a collection view cell inside a view controller that is in a container view") {
                expect(vcFromNib.view.firstVisibleCollectionViewCell(with: "Acre")).notTo(beNil())
            }
            
            it("should not have a collection view cell with 'Pernambuco' which is a collection view cell inside a view controller that is in a container view") {
                expect(vcFromNib.view.firstVisibleCollectionViewCell(with: "Pernambuco")).to(beNil())
            }
            
            // what about table view, list view?
            
            it("should have a label with the text 'Left Stack Label' in a UIStackView") {
                expect(vcFromNib.view.firstLabel(with: "Left Stack Label")).notTo(beNil())
            }
            
            it("should have a button with the text 'Right Stack Button' in a UIStackView") {
                expect(vcFromNib.view.firstButton(with: "Right Stack Button")).notTo(beNil())
            }
        }
    }
}
