import UIKit

extension UIViewController {
    func setBackButtonTitle(isHidden: Bool = false) {
        navigationItem.backButtonTitle = NSLocalizedString(key: "backButtonTitle")
        navigationItem.hidesBackButton = isHidden
    }
}
