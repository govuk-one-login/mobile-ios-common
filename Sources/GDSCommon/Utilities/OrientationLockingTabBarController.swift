import UIKit

public protocol OrientationLockingNavigationController: UIViewController {
    // Empty implementation
}

// OrientationLockingTabBarController prevents interface rotation preferences being overridden by UITabBarController.
// It ensures the correct view controller handles rotation.
public class OrientationLockingTabBarController: UITabBarController {
    override open var shouldAutorotate: Bool {
        if let vc = self.selectedViewController?.presentedViewController, vc is OrientationLockingNavigationController {
            return vc.shouldAutorotate
        } else {
            return super.shouldAutorotate
        }
    }
    
    override open var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        if let vc = self.selectedViewController?.presentedViewController, vc is OrientationLockingNavigationController {
            return vc.preferredInterfaceOrientationForPresentation
        } else {
            return super.preferredInterfaceOrientationForPresentation
        }
    }
    
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if let vc = self.selectedViewController?.presentedViewController, vc is OrientationLockingNavigationController {
            return vc.supportedInterfaceOrientations
        } else {
            return super.supportedInterfaceOrientations
        }
    }
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        if let vc = self.selectedViewController?.presentedViewController, vc is OrientationLockingNavigationController {
            return vc.preferredStatusBarStyle
        } else {
            return super.preferredStatusBarStyle
        }
    }
}
