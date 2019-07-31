import Nimble
import Quick
import UnIt
@testable import UnIt_SampleApp

class CGFloatPrecisionSpec: QuickSpec {
    override func spec() {
        var number: CGFloat!
        
        describe("Rounding") {
            beforeEach {
                number = nil
            }
            it("should round 234.865 up to 235 when zero decimal places is specified") {
                number = CGFloat(234.865)
                let roundedNumber = number.roundTo(decimalPlace: 0)
                expect(roundedNumber).to(equal(CGFloat(235)))
            }
            
            it("should round 14.644932 down to 14.64 when high degree of precision is specified") {
                number = CGFloat(14.644932)
                let roundedNumber = number.roundTo(decimalPlace: 2)
                expect(roundedNumber).to(equal(CGFloat(14.64)))
            }
            
            it("should round 14.645 up to 14.65 when high degree of precision is specified") {
                number = CGFloat(14.645)
                let roundedNumber = number.roundTo(decimalPlace: 2)
                expect(roundedNumber).to(equal(CGFloat(14.65)))
            }
        }
    }
}
