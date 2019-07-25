import Nimble
import Quick
import UnIt
@testable import UnIt_SampleApp

class DeviceSpec: QuickSpec {
    override func spec() {
        var subject: Device!
        var subjectFrame: CGSize!
        var subjectScaleFactor: CGFloat!
        var loadedVc: NibViewController!
        
        describe("Loading a view controller") {
            beforeEach {
                subject = nil
                subjectFrame = nil
                subjectScaleFactor =  nil
                loadedVc = nil
            }
            
            it("should have the root view's frame's size equal to the iPhoneSE's screensize, and root view's contentScaleFactor equal to the iPhoneSE's scaleFactor") {
                subject = .iPhoneSE
                subjectFrame = subject.dimensions.screensize
                subjectScaleFactor = subject.dimensions.scaleFactor
                loadedVc = ViewController.loadAndSetupViewControllerFromNib(String(describing: NibViewController.self), NibViewController.self, subject)
                expect(loadedVc.view.frame.size).to(equal(subjectFrame))
                expect(loadedVc.view.contentScaleFactor).to(equal(subjectScaleFactor))
            }
            
            it("should have the root view's frame's size equal to the iPhone6 screensize, and root view's contentScaleFactor equal to the iPhone6 scaleFactor") {
                subject = .iPhone6
                subjectFrame = subject.dimensions.screensize
                subjectScaleFactor = subject.dimensions.scaleFactor
                loadedVc = ViewController.loadAndSetupViewControllerFromNib(String(describing: NibViewController.self), NibViewController.self, subject)
                expect(loadedVc.view.frame.size).to(equal(subjectFrame))
                expect(loadedVc.view.contentScaleFactor).to(equal(subjectScaleFactor))
            }
            
            it("should have the root view's frame's size equal to the iPhone6Plus' screensize, and root view's contentScaleFactor equal to the iPhone6Plus' scaleFactor") {
                subject = .iPhone6Plus
                subjectFrame = subject.dimensions.screensize
                subjectScaleFactor = subject.dimensions.scaleFactor
                loadedVc = ViewController.loadAndSetupViewControllerFromNib(String(describing: NibViewController.self), NibViewController.self, subject)
                expect(loadedVc.view.frame.size).to(equal(subjectFrame))
                expect(loadedVc.view.contentScaleFactor).to(equal(subjectScaleFactor))
            }
            
            it("should have the root view's frame's size equal to the iPhone7Plus' screensize, and root view's contentScaleFactor equal to the iPhone7Plus' scaleFactor") {
                subject = .iPhone7Plus
                subjectFrame = subject.dimensions.screensize
                subjectScaleFactor = subject.dimensions.scaleFactor
                loadedVc = ViewController.loadAndSetupViewControllerFromNib(String(describing: NibViewController.self), NibViewController.self, subject)
                expect(loadedVc.view.frame.size).to(equal(subjectFrame))
                expect(loadedVc.view.contentScaleFactor).to(equal(subjectScaleFactor))
            }
            
            it("should have the root view's frame's size equal to the iPhoneX's screensize, and root view's contentScaleFactor equal to the iPhoneX's scaleFactor") {
                subject = .iPhoneX
                subjectFrame = subject.dimensions.screensize
                subjectScaleFactor = subject.dimensions.scaleFactor
                loadedVc = ViewController.loadAndSetupViewControllerFromNib(String(describing: NibViewController.self), NibViewController.self, subject)
                expect(loadedVc.view.frame.size).to(equal(subjectFrame))
                expect(loadedVc.view.contentScaleFactor).to(equal(subjectScaleFactor))

            }
            
            it("should have the root view's frame's size equal to the iPhoneXR's screensize, and root view's contentScaleFactor equal to the iPhoneXR's scaleFactor") {
                subject = .iPhoneXR
                subjectFrame = subject.dimensions.screensize
                subjectScaleFactor = subject.dimensions.scaleFactor
                loadedVc = ViewController.loadAndSetupViewControllerFromNib(String(describing: NibViewController.self), NibViewController.self, subject)
                expect(loadedVc.view.frame.size).to(equal(subjectFrame))
                expect(loadedVc.view.contentScaleFactor).to(equal(subjectScaleFactor))
            }
            
            it("should have the root view's frame's size equal to the iPhoneXSMax's screensize, and root view's contentScaleFactor equal to the iPhoneXSMax's scaleFactor") {
                subject = .iPhoneXSMax
                subjectFrame = subject.dimensions.screensize
                subjectScaleFactor = subject.dimensions.scaleFactor
                loadedVc = ViewController.loadAndSetupViewControllerFromNib(String(describing: NibViewController.self), NibViewController.self, subject)
                expect(loadedVc.view.frame.size).to(equal(subjectFrame))
                expect(loadedVc.view.contentScaleFactor).to(equal(subjectScaleFactor))
            }
        }
    }
}

