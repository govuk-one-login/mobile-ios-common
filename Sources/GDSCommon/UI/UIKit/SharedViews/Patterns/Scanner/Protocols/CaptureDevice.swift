import AVFoundation

public protocol CaptureDevice {
    associatedtype Input
    var input: Input { get throws }
    static func `for`(mediaType: AVMediaType) -> Self?
}

extension AVCaptureDevice: CaptureDevice {
    public var input: AVCaptureDeviceInput {
        get throws {
            try AVCaptureDeviceInput(device: self)
        }
    }
    
    public static func `for`(mediaType: AVMediaType) -> Self? {
        self.default(for: mediaType) as? Self
    }
}
