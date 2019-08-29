import Nimble
import Quick
import UnIt
@testable import UnItSpecsHost

class UIViewTextBasedFindingSpec: QuickSpec {
    override func spec() {
        var loadedVc: StoryboardedViewController!
        
        describe("ViewController's") {
            beforeEach() {
                loadedVc = UIViewController.loadFromStoryboard(named: "Main", withIdentifier: "StoryboardedViewController")
                loadedVc.runViewLifecycle(for: .iPhoneXSMax)
            }
            
            describe("first label") {
                
                it("should be red, given its text is 'Connected.'") {
                    expect(loadedVc.view.firstLabel(with: "Connected.")?.textColor).to(equal(UIColor.red))
                }
                
                it("should be nil, given its text is 'No text'") {
                    expect(loadedVc.view.firstLabel(with: "No text")).to(beNil())
                }
                
                it("should have a label with the text 'Left Stack Label' in a UIStackView") {
                    expect(loadedVc.view.firstLabel(with: "Left Stack Label")).notTo(beNil())
                }
                
                it("should have a label that has 'Montreal.' which is being set in viewDidAppear:") {
                    expect(loadedVc.view.firstLabel(with: "Montreal.")).notTo(beNil())
                }
            }
            
            describe("-- TV CELL") {
                
                it("should have a table view cell with text 'Alaska'") {
                    expect(loadedVc.view.firstVisibleTableViewCell(with: "Alaska")).notTo(beNil())
                }
                
                it("should not have a table view cell with text 'Mississippi'") {
                    expect(loadedVc.view.firstVisibleTableViewCell(with: "Mississippi")).to(beNil())
                }
                
                context("when the tableview is scrolled to the bottom") {
                    beforeEach {
                        loadedVc.tableView.scrollToRow(at: NSIndexPath(row: 54, section: 0) as IndexPath, at: UITableView.ScrollPosition.bottom, animated: false)
                    }
                    
                    it("should have a table view cell with text 'Wyoming'") {
                        expect(loadedVc.view.firstVisibleTableViewCell(with: "Wyoming")).notTo(beNil())
                    }
                }
            }
            
            describe("-- CV CELL") {
                
                it("should have a collection view cell with 'Ontario'") {
                    expect(loadedVc.view.firstVisibleCollectionViewCell(with: "Ontario")).notTo(beNil())
                }
                
                it("should not have a collection view cell with 'Newfoundland'") {
                    expect(loadedVc.view.firstVisibleCollectionViewCell(with: "Newfoundland")).to(beNil())
                }
            }
            
            describe("-- BUTTON") {
                
                it("should have its first 'Right Button' button be white") {
                    expect(loadedVc.view.firstButton(with: "Right Button")?.titleLabel?.textColor).to(equal(UIColor.white))
                }
                
                it("should not button that has 'No text'") {
                    expect(loadedVc.view.firstButton(with: "Blah blah")).to(beNil())
                }
                
                it("should have a button with the text 'Right Stack Button' in a UIStackView") {
                    expect(loadedVc.view.firstButton(with: "Right Stack Button")).notTo(beNil())
                }
            }
            
        }
    }
}
