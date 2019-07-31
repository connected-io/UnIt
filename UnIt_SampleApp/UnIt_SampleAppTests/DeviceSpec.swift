import Nimble
import Quick
import UnIt
@testable import UnIt_SampleApp

class DeviceSpec: QuickSpec {
    override func spec() {
        
        fdescribe("Accessing the dimensions of the device") {
            var subject: Device!
            
            beforeEach {
                subject = nil
            }
            
            it("should return the correct tuple consisting of size and scale factor for iPhoneSE") {
                subject = .iPhoneSE
                let dimensions = subject.dimensions
                expect(dimensions.screensize).to(equal(CGSize(width: 320, height: 568)))
                expect(dimensions.scaleFactor).to(equal(2.0))
            }
            
            it("should return the correct tuple consisting of size and scale factor for iPhone6") {
                subject = .iPhone6
                let dimensions = subject.dimensions
                expect(dimensions.screensize).to(equal(CGSize(width: 375, height: 667)))
                expect(dimensions.scaleFactor).to(equal(2.0))
            }
            
            it("should return the correct tuple consisting of size and scale factor for iPhone6Plus") {
                subject = .iPhone6Plus
                let dimensions = subject.dimensions
                expect(dimensions.screensize).to(equal(CGSize(width: 375, height: 667)))
                expect(dimensions.scaleFactor).to(equal(3.0))
            }
            
            it("should return the correct tuple consisting of size and scale factor for iPhone7Plus") {
                subject = .iPhone7Plus
                let dimensions = subject.dimensions
                expect(dimensions.screensize).to(equal(CGSize(width: 414, height: 736)))
                expect(dimensions.scaleFactor).to(equal(3.0))
            }
            
            it("should return the correct tuple consisting of size and scale factor for iPhoneX") {
                subject = .iPhoneX
                let dimensions = subject.dimensions
                expect(dimensions.screensize).to(equal(CGSize(width: 375, height: 812)))
                expect(dimensions.scaleFactor).to(equal(3.0))
            }
            
            it("should return the correct tuple consisting of size and scale factor for iPhoneXR") {
                subject = .iPhoneXR
                let dimensions = subject.dimensions
                expect(dimensions.screensize).to(equal(CGSize(width: 414, height: 896)))
                expect(dimensions.scaleFactor).to(equal(2.0))
            }
            
            it("should return the correct tuple consisting of size and scale factor for iPhoneXSMax") {
                subject = .iPhoneXSMax
                let dimensions = subject.dimensions
                expect(dimensions.screensize).to(equal(CGSize(width: 414, height: 896)))
                expect(dimensions.scaleFactor).to(equal(3.0))
            }
        }
    }
}

