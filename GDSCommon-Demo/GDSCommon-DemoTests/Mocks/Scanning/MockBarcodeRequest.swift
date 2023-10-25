import Vision

final class MockBarcodeRequest: VNRequest {
    private var mockResults: [VNObservation]?
    
    override var results: [VNObservation]? {
        mockResults
    }
    
    convenience init(results: [VNObservation]?) {
        self.init()
        self.mockResults = results
    }
}
