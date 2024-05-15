import AVFoundation

public protocol CaptureSession {
    associatedtype Input
    
    var layer: AVCaptureVideoPreviewLayer { get }

    var isRunning: Bool { get }
    func startRunning()
    func stopRunning()
    
    func beginConfiguration()
    func commitConfiguration()
    
    func canAddInput(_ input: Input) -> Bool
    func addInput(_ input: Input)
    
    func canAddOutput(_ output: AVCaptureOutput) -> Bool
    func addOutput(_ output: AVCaptureOutput)
}

extension AVCaptureSession: CaptureSession {
    public var layer: AVCaptureVideoPreviewLayer {
        AVCaptureVideoPreviewLayer(session: self)
    }
}
