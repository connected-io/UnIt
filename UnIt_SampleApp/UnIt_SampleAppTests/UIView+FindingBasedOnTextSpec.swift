import Nimble
import Quick
import UnIt
@testable import UnIt_SampleApp

class UIViewTextBasedFindingSpec: QuickSpec {
    override func spec() {
        var loadedVc: ViewController!
        
        describe("ViewController's") {
            beforeEach() {
                loadedVc = UIViewController.loadAndSetupViewControllerFromStoryboard("Main", "ViewController", Device.iPhoneXSMax)
            }
            
            describe("first label") {
                
                it("should be red, given the text is 'Connected.'") {
                    expect(loadedVc.view.firstLabel(with: "Connected.")?.textColor).to(equal(UIColor.red))
                }
                
                it("should be nil, given the text is 'No text'") {
                    expect(loadedVc.view.firstLabel(with: "No text")).to(beNil())
                }
                
                it("should have a label with the text 'Left Stack Label' in a UIStackView") {
                    expect(loadedVc.view.firstLabel(with: "Left Stack Label")).notTo(beNil())
                }
                
                it("should have a label that has 'Montreal.' which is being set in viewDidAppear:") {
                    expect(loadedVc.view.firstLabel(with: "Montreal.")).notTo(beNil())
                }
            }
            
            describe("table view cell") {
                
                it("should exist, given the text 'Alaska'") {
                    expect(loadedVc.view.firstVisibleTableViewCell(with: "Alaska")).notTo(beNil())
                }
                
                it("should not exist, given the text 'Mississippi'") {
                    expect(loadedVc.view.firstVisibleTableViewCell(with: "Mississippi")).to(beNil())
                }
                
                context("when the tableview is scrolled to the bottom") {
                    beforeEach {
                        loadedVc.tableView.scrollToRow(at: NSIndexPath(row: 54, section: 0) as IndexPath, at: UITableView.ScrollPosition.bottom, animated: false)
                    }
                    
                    it("should exist, given the text 'Wyoming'") {
                        expect(loadedVc.view.firstVisibleTableViewCell(with: "Wyoming")).notTo(beNil())
                    }
                }
            }
            
            describe("collection view cell") {
                
                it("should should exist, given the text 'Ontario'") {
                    expect(loadedVc.view.firstVisibleCollectionViewCell(with: "Ontario")).notTo(beNil())
                }
                
                it("should not exist, given the text 'Newfoundland'") {
                    expect(loadedVc.view.firstVisibleCollectionViewCell(with: "Newfoundland")).to(beNil())
                }
            }
            
            describe("first button") {
                
                it("should be white, given the text 'Right Button'") {
                    expect(loadedVc.view.firstButton(with: "Right Button")?.titleLabel?.textColor).to(equal(UIColor.white))
                }
                
                it("should not exist, given the text 'Blah blah'") {
                    expect(loadedVc.view.firstButton(with: "Blah blah")).to(beNil())
                }
                
                it("should exist in a UIStackView, given the text 'Right Stack Button'") {
                    expect(loadedVc.view.firstButton(with: "Right Stack Button")).notTo(beNil())
                }
            }
            
        }
    }
}
