import UIKit

@MainActor
public protocol QRScanningViewModel {
    var title: String { get }
    var instructionText: String { get }
    
    func didScan(value: String, in view: UIView) async
}
