import UIKit

extension UINavigationController {
    public func popToNewViewController(_ vc: UIViewController, animated: Bool) {
        guard viewControllers.count > 0 else { return }
        var vcs = viewControllers
        vcs.insert(vc, at: vcs.count-1)
        setViewControllers(vcs, animated: false)
        popToViewController(vc, animated: animated)
    }
}
