import GDSCommon
import UIKit

class MockQRScanningViewModel: QRScanningViewModel {
    let title: String
    let instructionText: String
    let rightBarButtonTitle: GDSLocalisedString? = "right bar button"
    
    let dialogPresenter: DialogPresenter
    let onScan: () -> Void
    let dismissAction: () -> Void
    
    init(title: String = "QR Scanning Title",
         instructionText: String = "QR Scanning instruction area, we can instruct the user from here",
         dialogPresenter: DialogPresenter,
         onScan: @escaping () -> Void,
         dismissAction: @escaping () -> Void) {
        self.title = title
        self.instructionText = instructionText
        self.dialogPresenter = dialogPresenter
        self.onScan = onScan
        self.dismissAction = dismissAction
    }
    
    @MainActor
    public func didScan(value: String, in view: UIView) async {
        // perform validation
        guard value.contains("ABC123") else {
            await dialogPresenter.present(onView: view,
                                          shouldLoad: false,
                                          title: "Badly Formatted QR Code")
            return
        }
        // show success screen
        await dialogPresenter.present(onView: view,
                                      shouldLoad: false,
                                      title: "QR Code Scanned")
        onScan()
    }
    
    func didDismiss() {
        dismissAction()
    }
}
