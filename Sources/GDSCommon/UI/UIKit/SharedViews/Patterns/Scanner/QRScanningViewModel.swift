import Foundation

public protocol QRScanningViewModel {
    var title: String { get }
    var instructionText: String { get }
    var successMessage: String { get }
    var shouldShowAlert: Bool { get }
    var shouldDismissViewAfterScanComplete: Bool { get }
    var format: String? { get }
    var alertTitle: String { get }
    var alertMessage: String { get }
    var alertAction: String { get }
}
