import Vision

final class MockDetectBarcodeRequest: VNDetectBarcodesRequest {
    let requestHandler: VNRequestCompletionHandler?
    
    override init(completionHandler: VNRequestCompletionHandler? = nil) {
        self.requestHandler = completionHandler
        super.init(completionHandler: completionHandler)
    }
}
