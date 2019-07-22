import Foundation
import Nimble
import Quick
import UnIt
@testable import UnIt_SampleApp

class UIViewTextBasedFindingSpec: QuickSpec {
    override func spec() {
        var subject : NibViewController!
        
        describe("ViewController from nib") {
            beforeEach() {
                subject = UIViewController.loadAndSetupViewControllerFromNib("NibViewController", NibViewController.self, Device.iPhoneXS)
            }
            
            it("should have a label that has text: 'Top View Controller Label'") {
                expect(subject.view.firstLabel(with: "Top View Controller Label")).notTo(beNil())
            }
            
            it("should have a button that has text: 'Bottom View Controller Button'") {
                expect(subject.view.firstButton(with: "Bottom View Controller Button")).notTo(beNil())
            }
            
            it("should not have a label that has text: 'No Label'") {
                expect(subject.view.firstLabel(with: "No Label")).to(beNil())
            }
            
            it("should have a collection view cell with 'Acre' which is a collection view cell inside a view controller that is in a container view") {
                expect(subject.view.firstVisibleCollectionViewCell(with: "Acre")).notTo(beNil())
            }
            
            it("should not have a collection view cell with 'Pernambuco' which is a collection view cell inside a view controller that is in a container view") {
                expect(subject.view.firstVisibleCollectionViewCell(with: "Pernambuco")).to(beNil())
            }
            
            // what about table view, list view?
            
            it("should have a label with the text 'Left Stack Label' in a UIStackView") {
                expect(subject.view.firstLabel(with: "Left Stack Label")).notTo(beNil())
            }
            
            it("should have a button with the text 'Right Stack Button' in a UIStackView") {
                expect(subject.view.firstButton(with: "Right Stack Button")).notTo(beNil())
            }
        }
    }
}
