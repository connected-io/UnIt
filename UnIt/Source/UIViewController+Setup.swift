
public extension UIViewController {
    /**
     Due to the laziness of UIKit, the view lifecycle does not run properly when instantiating view/view controllers in unit tests. This method makes sure that the viewController's view lifecycle is ran to match UIKit (when a user interacts with the app). It will **roughly** follow the following view lifecycle:
     - viewDidLoad()
     - viewWillAppear(animated: Bool)
     - viewWillLayoutSubviews()
     - viewDidLayoutSubviews()
     - viewDidAppear(animated: Bool)
     - viewWillLayoutSubviews()
     - viewDidLayoutSubviews()
     - parameters:
        - device: the device screen size that the test suite is testing against.
     */
    
    func runViewLifecycle(for device: Device) {
        let _ = view
        view.frame = CGRect(origin: .zero, size: device.dimensions.screensize)
        view.contentScaleFactor = device.dimensions.scaleFactor
        viewWillAppear(false)
        view.layoutIfNeeded() // Handles any view changes after viewWillAppear if needed.
        viewDidAppear(false)
        view.layoutIfNeeded() // Handles any view changes after viewDidAppear if needed.
    }
}
