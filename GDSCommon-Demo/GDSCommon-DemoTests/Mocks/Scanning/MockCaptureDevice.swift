import AVFoundation
import GDSCommon

final class MockCaptureDevice: CaptureDevice {
    
    static func `for`(mediaType: AVMediaType) -> Self? {
        Self()
    }
    
    var input: MockCaptureDeviceInput {
        MockCaptureDeviceInput()
    }
}

struct MockCaptureDeviceInput {
    
}
