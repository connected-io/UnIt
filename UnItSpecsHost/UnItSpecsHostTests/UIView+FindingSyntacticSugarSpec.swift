import Nimble
import Quick
import UnIt
@testable import UnItSpecsHost

class UIViewFindingSyntacticSugarSpec: QuickSpec {
    override func spec() {
        var multipleElementsVc: MultipleSameElementsViewController!
        
        describe("ViewController with multiple of the same elements") {
            beforeEach {
                multipleElementsVc = UIViewController.loadFromNib(named: "MultipleSameElementsViewController")
                multipleElementsVc.runViewLifecycle(for: .iPhoneX)
            }
            
            it("should contain 2 labels with the text: Toronto") {
                let torontoLabels = multipleElementsVc.view.labelsPassing(test: { label in
                    return label.text == "Toronto"
                })
                expect(torontoLabels.count).to(equal(2))
            }
            
            it("should contain 4 labels with red text color") {
                let redLabels = multipleElementsVc.view.labelsPassing(test: { label in
                    return label.textColor == UIColor.red
                })
                expect(redLabels.count).to(equal(4))
            }
            
            it("should contain 0 labels with a grey background color") {
                let greyLabels = multipleElementsVc.view.labelsPassing(test: { label in
                    return label.backgroundColor == UIColor.gray
                })
                expect(greyLabels.count).to(equal(0))
            }
            
            it("should contain 5 buttons with a corner radius of 5") {
                let buttons = multipleElementsVc.view.buttonsPassing(test: { button in
                    return button.layer.cornerRadius == 5
                })
                expect(buttons.count).to(equal(5))
            }
            
            it("should contain 3 table view cells with the text: 'Blue'") {
                let cells = multipleElementsVc.view.tableViewCellsPassing(test: { cell in
                    return cell.firstLabel(with: "Blue") != nil
                })
                expect(cells.count).to(equal(3))
            }
            
            it("should have 3 table view cells with font size: 11") {
                let cells = multipleElementsVc.view.tableViewCellsPassing(test: { cell in
                    return cell.containsView(ofType: UILabel.self, passing: { label in
                        return label.font.pointSize == 11
                    })
                })
                expect(cells.count).to(equal(3))
            }
            
            it("should have 3 collection view cells with the text: 'Blue'") {
                let cells = multipleElementsVc.view.collectionViewCellPassing(test: { cell in
                    return cell.firstLabel(with: "Blue") != nil
                })
                expect(cells.count).to(equal(3))
            }
            
            it("should have 3 table view cells with font size: 13") {
                let cells = multipleElementsVc.view.collectionViewCellPassing(test: { cell in
                    return cell.containsView(ofType: UILabel.self, passing: { label in
                        return label.font.pointSize == 13
                    })
                })
                expect(cells.count).to(equal(4))
            }
        }
    }
}
