import UIKit

extension UIViewController {
    func setBackButtonTitle(isHidden: Bool = false) {
        let backButtonTitle = GDSLocalisedString(stringKey: "GDSCommonBackButton",
                                                 bundle: .module)
        let backButton = UIBarButtonItem(title: backButtonTitle.value, style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        navigationItem.hidesBackButton = isHidden
    }
}
