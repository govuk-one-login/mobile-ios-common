import UIKit

extension UIViewController {
    func setBackButtonTitle(isHidden: Bool = false) {
        
        print(NSLocalizedString(key: "GDSCommonBackButton", bundle: .module))
        print(isHidden)
        navigationItem.backButtonTitle = NSLocalizedString(key: "GDSCommonBackButton", bundle: .module)
        navigationItem.hidesBackButton = isHidden
    }
}
