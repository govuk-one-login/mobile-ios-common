import UIKit

extension UIViewController {
    func setBackButtonTitle(isHidden: Bool = false) {
        let backButtonTitle = GDSLocalisedString(stringKey: "GDSCommonBackButton",
                                                 bundle: .module)
        navigationItem.backButtonTitle = backButtonTitle.value
        navigationItem.hidesBackButton = isHidden
    }
}
