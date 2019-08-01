import Nimble
import Quick
import UnIt
@testable import UnIt_SampleApp

class DeviceSpec: QuickSpec {
    override func spec() {
        
        describe("The dimensions of the device") {
            var subject: Device!
            
            beforeEach {
                subject = nil
            }
            
            it("should be the size and scale factor of iPhoneSE") {
                subject = .iPhoneSE
                let dimensions = subject.dimensions
                expect(dimensions.screensize).to(equal(CGSize(width: 320, height: 568)))
                expect(dimensions.scaleFactor).to(equal(2.0))
            }
            
            it("should be the size and scale factor of iPhone6") {
                subject = .iPhone6
                let dimensions = subject.dimensions
                expect(dimensions.screensize).to(equal(CGSize(width: 375, height: 667)))
                expect(dimensions.scaleFactor).to(equal(2.0))
            }
            
            it("should be the size and scale factor of iPhone6S") {
                subject = .iPhone6S
                let dimensions = subject.dimensions
                expect(dimensions.screensize).to(equal(CGSize(width: 375, height: 667)))
                expect(dimensions.scaleFactor).to(equal(2.0))
            }
            
            it("should be the size and scale factor of iPhone7") {
                subject = .iPhone7
                let dimensions = subject.dimensions
                expect(dimensions.screensize).to(equal(CGSize(width: 375, height: 667)))
                expect(dimensions.scaleFactor).to(equal(2.0))
            }
            
            it("should be the size and scale factor of iPhone8") {
                subject = .iPhone8
                let dimensions = subject.dimensions
                expect(dimensions.screensize).to(equal(CGSize(width: 375, height: 667)))
                expect(dimensions.scaleFactor).to(equal(2.0))
            }
            
            it("should be the size and scale factor of iPhone6Plus") {
                subject = .iPhone6Plus
                let dimensions = subject.dimensions
                expect(dimensions.screensize).to(equal(CGSize(width: 375, height: 667)))
                expect(dimensions.scaleFactor).to(equal(3.0))
            }
            
            it("should be the size and scale factor of iPhone6SPlus") {
                subject = .iPhone6SPlus
                let dimensions = subject.dimensions
                expect(dimensions.screensize).to(equal(CGSize(width: 375, height: 667)))
                expect(dimensions.scaleFactor).to(equal(3.0))
            }
            
            it("should be the size and scale factor of iPhone7Plus") {
                subject = .iPhone7Plus
                let dimensions = subject.dimensions
                expect(dimensions.screensize).to(equal(CGSize(width: 414, height: 736)))
                expect(dimensions.scaleFactor).to(equal(3.0))
            }
            
            it("should be the size and scale factor of iPhone8Plus") {
                subject = .iPhone7Plus
                let dimensions = subject.dimensions
                expect(dimensions.screensize).to(equal(CGSize(width: 414, height: 736)))
                expect(dimensions.scaleFactor).to(equal(3.0))
            }
            
            it("should be the size and scale factor of iPhoneX") {
                subject = .iPhoneX
                let dimensions = subject.dimensions
                expect(dimensions.screensize).to(equal(CGSize(width: 375, height: 812)))
                expect(dimensions.scaleFactor).to(equal(3.0))
            }
            
            it("should be the size and scale factor of iPhoneXS") {
                subject = .iPhoneXS
                let dimensions = subject.dimensions
                expect(dimensions.screensize).to(equal(CGSize(width: 375, height: 812)))
                expect(dimensions.scaleFactor).to(equal(3.0))
            }
            
            it("should be the size and scale factor of iPhoneXR") {
                subject = .iPhoneXR
                let dimensions = subject.dimensions
                expect(dimensions.screensize).to(equal(CGSize(width: 414, height: 896)))
                expect(dimensions.scaleFactor).to(equal(2.0))
            }
            
            it("should be the size and scale factor of iPhoneXSMax") {
                subject = .iPhoneXSMax
                let dimensions = subject.dimensions
                expect(dimensions.screensize).to(equal(CGSize(width: 414, height: 896)))
                expect(dimensions.scaleFactor).to(equal(3.0))
            }
        }
    }
}

