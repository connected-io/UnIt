import Foundation

/**
 You may have noticed that when a constraint conflict occurs the logs spit out a bunch of constraint conflicts in the system log like this:
 --------------
 LayoutConstraints] Unable to simultaneously satisfy constraints.
 Probably at least one of the constraints in the following list is one you don't want.
 Try this:
 (1) look at each constraint and try to figure out which you don't expect;
 (2) find the code that added the unwanted constraint or constraints and fix it.
 (
 "<NSLayoutConstraint:0x600000d08640 UIView:0x7fa73a7092f0.height == 150   (active)>",
 "<NSLayoutConstraint:0x600000d09900 UIView:0x7fa73a628a90.height == 100   (active)>",
 "<NSLayoutConstraint:0x600000d0a8a0 UIView:0x7fa73a7092f0.height == UIView:0x7fa73a628a90.height   (active)>"
 )
 
 Will attempt to recover by breaking constraint
 <NSLayoutConstraint:0x600000d08640 UIView:0x7fa73a7092f0.height == 150   (active)>
 ---------------
 
 This file is responsible for capturing those constraint breaks and making them readily available as a view controller property. As a result,
 you can unit test your view controller and check for its conflicting constraints like this - viewController.conflictingConstraints.
 
 HOWEVER, in order to capture these constraints I needed to swizzle the private UIView selector: "engine:willBreakConstraint:dueToMutuallyExclusiveConstraints:".
 The moment you use this file, it changes that selector implementation for as long as your app/tests run. Just a warning. If Apple changes this function or
 anything we may be doomed and you won't be able to use this file.
 */

extension UIViewController {
    /**
     Getter to return all the conflicting constraints and groups them together based on how they are produced in the log.
     - Returns: An array of arrays (which contain the related conflicting constraints).
     */
    public var conflictingConstraints: [[NSLayoutConstraint]] {
        get {
            return view.conflictingConstraints
        }
    }
    
    /**
     If you want to test your **UIViewController** for constraint conflicts, call this method **BEFORE** kickUIKit(). Afterwards you can test your view controller
     for conflicting constraints with viewController.conflictingConstraints. Your view controller will now be able to handle constraint conflicts.
     - Warning: This function uses swizzling to change a **PRIVATE** UIView function: (engine:willBreakConstraint:dueToMutuallyExclusiveConstraints:)'s implementation in order to capture the conflicting constraints. Calling this once will affect the rest of the app.
     */
    public func setupToCaptureConflictingConstraints() {
        view.setupToCaptureConflictingConstraints()
    }
}

extension UIView {
    /**
     The black magic of swizzling to replace the implementation of the UIView **PRIVATE** method: engine:willBreakConstraint:dueToMutuallyExclusiveConstraints:
     - Note: This static let is Swift 4's recommended way to replace the deprecated dispatch_once method.
     */
    static let swizzleAutoLayoutAlertMethodOnce: Void = {
        guard let originalMethod = class_getInstanceMethod(UIView.self, NSSelectorFromString("engine:willBreakConstraint:dueToMutuallyExclusiveConstraints:")) else {
            return
        }
        guard let swizzledMethod = class_getInstanceMethod(UIView.self, #selector(handleConstraintBreak(engine:breakConstraint:mutuallyExclusiveConstraints:))) else {
            return
        }
        method_exchangeImplementations(swizzledMethod, originalMethod)
    }()

    /**
     In order to attach conflicting constraints to a view without subclassing, I needed to create an associated object to the view.
     The associated object will be conflicting constraints that it captures from our swizzled method.
     */
    private struct AssociatedKeys {
        static var SavedConflictingConstraintsKey = "UnIt_SavedConflictingConstraintsKey"
    }
    
    private var savedConflictConstraints:[[NSLayoutConstraint]]? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.SavedConflictingConstraintsKey) as? [[NSLayoutConstraint]]
        }
        set(newValue) {
            guard let newValue = newValue else { return }
            objc_setAssociatedObject(self,
                                     &AssociatedKeys.SavedConflictingConstraintsKey,
                                     newValue,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /**
     This is our method that will replace: "engine:willBreakConstraint:dueToMutuallyExclusiveConstraints:". It can be broken down into 2 parts:
     1. Capture the conflicting constraints.
     2. Execute the original implementation which is to print the constraint breaks to the system log.
     */
    @objc func handleConstraintBreak(engine: Any, breakConstraint: NSLayoutConstraint, mutuallyExclusiveConstraints: [NSLayoutConstraint]) {
        if (savedConflictConstraints == nil) {
            savedConflictConstraints = []
        }
        savedConflictConstraints?.append(mutuallyExclusiveConstraints)
        self.handleConstraintBreak(engine: engine, breakConstraint: breakConstraint, mutuallyExclusiveConstraints: mutuallyExclusiveConstraints)
    }
    
    /**
     Getter to retrieve all the conflicting constraints associated with that view.
     - Returns: An array of arrays (which contain the related conflicting constraints).
     */
    public var conflictingConstraints: [[NSLayoutConstraint]] {
        get {
            return savedConflictConstraints ?? []
        }
    }
    
    /**
     Sets up the app to replace "engine:willBreakConstraint:dueToMutuallyExclusiveConstraints:" with our swizzled out method.
     - Warning: Once called, our swizzled method will exist for the rest of the app. There is no going back.
     - Note: let _ = UIView.swizzleAutoLayoutAlertMethodOnce required to only be called once. Replaces the deprecated dispatch_once method.
     */
    fileprivate func setupToCaptureConflictingConstraints() {
        let _ = UIView.swizzleAutoLayoutAlertMethodOnce
    }
}
