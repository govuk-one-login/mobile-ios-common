import GDSCommon

public class MockQRScanningViewModel: QRScanningViewModel {
    public var title: String
    public var instructionText: String
    public var successMessage: String
    public var format: String?
    public var shouldShowAlert: Bool
    public var shouldDismissViewAfterScanComplete: Bool
    public var alertTitle: String
    public var alertMessage: String
    public var alertAction: String
    
    init(title: String = "QR Scanning Title",
         instructionText: String = "QR Scanning instruction area, we can instruct the user from here",
         successMessage: String = "QR Code Scanned",
         format: String? = nil,
         shouldShowAlert: Bool = false,
         shouldDismissViewAfterScanComplete: Bool = true,
         alertTitle: String = "QR Code title",
         alertMessage: String = "This code is in the incorrect format",
         alertAction: String = "Ok") {
        self.title = title
        self.instructionText = instructionText
        self.successMessage = successMessage
        self.format = format
        self.shouldShowAlert = shouldShowAlert
        self.shouldDismissViewAfterScanComplete = shouldDismissViewAfterScanComplete
        self.alertTitle = alertTitle
        self.alertMessage = alertMessage
        self.alertAction = alertAction
    }
}
