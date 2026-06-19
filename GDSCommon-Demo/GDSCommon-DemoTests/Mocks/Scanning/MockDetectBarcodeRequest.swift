import Vision

final class MockDetectBarcodeRequest: VNDetectBarcodesRequest {
    let requestHandler: VNRequestCompletionHandler?
    private(set) var wasCancelled: Bool = false

    override init(completionHandler: VNRequestCompletionHandler? = nil) {
        self.requestHandler = completionHandler
        super.init(completionHandler: completionHandler)
    }

    override func cancel() {
        wasCancelled = true
        super.cancel()
    }
}
