import Nimble
import Quick
import UnIt
@testable import UnIt_SampleApp

class CGSizeComparingSpec: QuickSpec {
    override func spec() {
        var size: CGSize!
        var otherSize: CGSize!
        
        describe("Comparing this size to other size") {
            beforeEach {
                size = nil
                otherSize = nil
            }
            it("should return true if other size is the same width and height, when two decimal places is specified") {
                size = CGSize(width: 200.54, height: 12.923509)
                otherSize = CGSize(width: 200.54, height: 12.923509)
                expect(size.isEqualTo(otherSize: otherSize, precision: 2)).to(be(true))
            }
            
            it("should return true if other size is the same width and height, when zero decimal places is specified") {
                size = CGSize(width: 200.54, height: 12.923509)
                otherSize = CGSize(width: 200.54, height: 12.923509)
                expect(size.isEqualTo(otherSize: otherSize, precision: 0)).to(be(true))
            }
            
            it("should return true if it and the other size are of zero width and height, when two decimal places is specified") {
                size = CGSize(width: 0, height: 0)
                otherSize = CGSize(width: 0, height: 0)
                expect(size.isEqualTo(otherSize: otherSize, precision: 2)).to(be(true))
            }
        }
    }
    
}
