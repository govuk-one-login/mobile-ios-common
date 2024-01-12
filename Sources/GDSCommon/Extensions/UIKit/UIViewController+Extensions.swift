import UIKit

extension UIViewController {
    func setBackButtonTitle(isHidden: Bool = false) {
        let backButtonTitle = GDSLocalisedString(stringKey: "GDSCommon-backButtonTitle",
                                                 bundle: .module)
        navigationItem.backButtonTitle = backButtonTitle.value
        navigationItem.hidesBackButton = isHidden
    }
}
