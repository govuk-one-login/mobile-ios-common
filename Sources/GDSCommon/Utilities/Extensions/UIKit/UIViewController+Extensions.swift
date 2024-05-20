import UIKit

extension UIViewController {
    func setBackButtonTitle(isHidden: Bool = false) {
        navigationItem.backButtonTitle = NSLocalizedString(key: "GDSCommonBackButton", bundle: .module)
        navigationItem.hidesBackButton = isHidden
    }
}
