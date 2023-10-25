import Vision

final class MockBarcodeObservation: VNBarcodeObservation {
    private var mockValue: String?
    
    override var payloadStringValue: String? {
        mockValue
    }
    
    convenience init(_ mockValue: String) {
        self.init()
        self.mockValue = mockValue
    }
}
