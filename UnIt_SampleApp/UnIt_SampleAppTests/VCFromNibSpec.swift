//
//  VCFromNibSpec.swift
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

class VCFromNibSpec: QuickSpec {
    override func spec() {
        var nibSubject : NibViewController!
 
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
    }
}
