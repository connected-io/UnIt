import Foundation
import Nimble
import Quick
import PieceOfCake
@testable import PieceOfCake_SampleApp

class SampleAppSpec: QuickSpec {
    override func spec() {
        var subject : ViewController!
        var nibSubject : NibViewController!
        var actionSubject : ActionViewController!
        var overlapSubject : OverlapViewController!
        var labelSubject: LabelViewController!
        var constraintBreakSubject: ConstraintBreakViewController!
        var offscreenSubject: OffScreenViewController!
        
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

        describe("ViewController from nib") {
            beforeEach() {
                nibSubject = UIViewController.loadAndSetupViewControllerFromNib("NibViewController", NibViewController.self, Device.iPhoneXS)
            }

            it("should not be nil") {
                expect(nibSubject).notTo(beNil())
                expect(nibSubject.view).notTo(beNil())
            }

            it("should have a label that has text: 'Top View Controller Label'") {
                expect(nibSubject.view.firstLabel(with: "Top View Controller Label")).notTo(beNil())

            }

            it("should have a button that has text: 'Bottom View Controller Button'") {
                expect(nibSubject.view.firstButton(with: "Bottom View Controller Button")).notTo(beNil())

            }

            it("should not have a label that has text: 'No Label'") {
                expect(nibSubject.view.firstLabel(with: "No Label")).to(beNil())
            }

            it("should have a collection view cell with 'Acre' which is a collection view cell inside a view controller that is in a container view") {
                expect(nibSubject.view.firstVisibleCollectionViewCell(with: "Acre")).notTo(beNil())
            }

            it("should not have a collection view cell with 'Pernambuco' which is a collection view cell inside a view controller that is in a container view") {
                expect(nibSubject.view.firstVisibleCollectionViewCell(with: "Pernambuco")).to(beNil())
            }

            it("should have a label with the text 'Left Stack Label' in a UIStackView") {
                expect(nibSubject.view.firstLabel(with: "Left Stack Label")).notTo(beNil())
            }

            it("should have a button with the text 'Right Stack Button' in a UIStackView") {
                expect(nibSubject.view.firstButton(with: "Right Stack Button")).notTo(beNil())
            }
        }

        describe("ViewController with user inputs") {
            beforeEach() {
                actionSubject = UIViewController.loadAndSetupViewControllerFromNib("ActionViewController", ActionViewController.self, Device.iPhone7Plus)
            }

            it("should not be nil") {
                expect(actionSubject).notTo(beNil())
                expect(actionSubject.view).notTo(beNil())
            }

            it("should have disabled switches") {
                expect(actionSubject.textFieldSwitch.isOn).to(beFalse())
                expect(actionSubject.buttonSwitch.isOn).to(beFalse())
            }

            it("should have 3 hidden buttons") {
                expect(actionSubject.firstHiddenButton.isTrulyVisible()).to(beFalse())
                expect(actionSubject.secondHiddenButton.isTrulyVisible()).to(beFalse())
                expect(actionSubject.buttonInHiddenView.isTrulyVisible()).to(beFalse())
            }

            context("When the user taps the action button - simulating the user tapping a button") {
                beforeEach {
                    actionSubject.buttonSwitch.isOn = false
                    actionSubject.button.tap()
                }

                it("should enable the button switch") {
                    expect(actionSubject.buttonSwitch.isOn).to(beTrue())
                }
            }

            context("When the user types into the text field - simulating the user typing into a textfield") {
                beforeEach {
                    actionSubject.textFieldSwitch.isOn = false
                    actionSubject.textField.type(with: "Typing this in")
                }

                it("should enable the text field switch which turns on when the textfield length > 0") {
                    expect(actionSubject.textFieldSwitch.isOn).to(beTrue())
                }
            }

            context("When the user types letters and numbers into the numeric text field") {
                beforeEach {
                    actionSubject.numericTextField.type(with: "1a2b3c")
                }

                it("should have '123' text") {
                    expect(actionSubject.numericTextField.text).to(be("123"))
                }
            }

            context("When the user pastes an invalid and a valid string into a numeric text field") {
                beforeEach {
                    actionSubject.numericTextField.paste(with: "1a2b3c")
                    actionSubject.numericTextField.paste(with: "12345")
                }

                it("should display only '12345' in the numeric text field") {
                    expect(actionSubject.numericTextField.text).to(be("12345"))
                }
            }
        }

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
                    expect(labelSubject.oneLineLabelNoTruncation.isTruncated()).to(equal(false))
                    expect(labelSubject.twoLineLabelNoTruncation.isTruncated()).to(equal(false))
                    expect(labelSubject.infiniteLineLabel.isTruncated()).to(equal(false))
                }

                it("should find the truncated labels") {
                    expect(labelSubject.oneLineLabelWithTruncation.isTruncated()).to(equal(true))
                    expect(labelSubject.oneLineLabelWithIncreasingFontToTruncate.isTruncated()).to(equal(true))
                    expect(labelSubject.oneLineLabelThatSizeWillDecreaseToTruncate.isTruncated()).to(equal(true))
                    expect(labelSubject.threeLineLabelWithTruncation.isTruncated()).to(equal(true))
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
                    expect(labelSubject.oneLineLabelNoTruncation.isTruncated()).to(equal(true))
                }
            }
        }
    }
}
