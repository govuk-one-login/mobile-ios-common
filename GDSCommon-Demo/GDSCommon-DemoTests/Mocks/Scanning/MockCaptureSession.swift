import AVFoundation
import GDSCommon

final class MockCaptureSession: CaptureSession {
    private(set) var output: AVCaptureOutput?
    private(set) var removedOutput: AVCaptureOutput?

    var layer: AVCaptureVideoPreviewLayer {
        AVCaptureVideoPreviewLayer()
    }
    
    var isRunning: Bool = false
    
    func startRunning() {
        isRunning = true
    }
    
    func stopRunning() {
        isRunning = false
    }
    
    func beginConfiguration() {
        
    }
    
    func commitConfiguration() {
        
    }
    
    func canAddInput(_ input: MockCaptureDeviceInput) -> Bool {
        true
    }
    
    func addInput(_ input: MockCaptureDeviceInput) {
        
    }
    
    func canAddOutput(_ output: AVCaptureOutput) -> Bool {
        true
    }
    
    func addOutput(_ output: AVCaptureOutput) {
        self.output = output
    }

    // Helper method for testing cleanup
    func removeOutput(_ output: AVCaptureOutput) {
        if self.output === output {
            removedOutput = output
            self.output = nil
        }
    }
}
