import UIKit

public protocol QRScanningViewModel {
    var title: String { get }
    var instructionText: String { get }
    var rightBarButtonTitle: GDSLocalisedString? { get }
    
    func didScan(value: String, in view: UIView) async
    func didDismiss()
}
