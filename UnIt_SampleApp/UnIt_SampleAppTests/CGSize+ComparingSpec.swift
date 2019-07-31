import Nimble
import Quick
import UnIt
@testable import UnIt_SampleApp

class CGSizeComparingSpec: QuickSpec {
    override func spec() {
        fdescribe("Comparing this size to other size") {
            var size: CGSize!
            var otherSize: CGSize!
            
            beforeEach {
                size = nil
                otherSize = nil
            }
            it("should return true if other size is the same width and height, when high degree of precision is specified") {
                size = CGSize(width: 200.54, height: 12.923509)
                otherSize = CGSize(width: 200.54, height: 12.923509)
                expect(size.isRoughlyEqualTo(otherSize: otherSize, precision: 2)).to(beTruthy())
            }
            
            it("should return true if other size is the same width and height, when zero decimal places is specified") {
                size = CGSize(width: 200.54, height: 12.923509)
                otherSize = CGSize(width: 200.54, height: 12.923509)
                expect(size.isRoughlyEqualTo(otherSize: otherSize, precision: 0)).to(beTruthy())
            }
            
            it("should be able to match zero sizes, when high degree of precision is specified") {
                size = CGSize(width: 0, height: 0)
                otherSize = CGSize(width: 0, height: 0)
                expect(size.isRoughlyEqualTo(otherSize: otherSize, precision: 2)).to(beTruthy())
            }
            
            it("should be able to match zero widths and zero heights, when high degree of precision is specified") {
                size = CGSize(width: 0, height: 423.43)
                otherSize = CGSize(width: 0, height: 423.43)
                expect(size.isRoughlyEqualTo(otherSize: otherSize, precision: 2)).to(beTruthy())
            }
            
            it("should be able to match non-zero widths and zero heights, when high degree of precision is specified") {
                size = CGSize(width: 423.43, height: 0)
                otherSize = CGSize(width: 423.43, height: 0)
                expect(size.isRoughlyEqualTo(otherSize: otherSize, precision: 2)).to(beTruthy())
            }
        }
    }
}
