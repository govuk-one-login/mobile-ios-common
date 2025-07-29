import AVFoundation
@testable import GDSCommon
import Testing

struct AVCaptureVideoOrientationTests {
    @Test("Initialise AVCaptureVideoOrientation from DeviceOrientation")
    func testCastFromDeviceOrientation() {
        #expect(
            AVCaptureVideoOrientation(deviceOrientation: .portrait)
            == .portrait
        )
        #expect(
            AVCaptureVideoOrientation(deviceOrientation: .portraitUpsideDown)
            == .portraitUpsideDown
        )
        #expect(
            AVCaptureVideoOrientation(deviceOrientation: .landscapeRight)
            == .landscapeLeft
        )
        #expect(
            AVCaptureVideoOrientation(deviceOrientation: .landscapeLeft)
            == .landscapeRight
        )
        #expect(
            AVCaptureVideoOrientation(deviceOrientation: .faceUp) == nil
        )
        #expect(
            AVCaptureVideoOrientation(deviceOrientation: .faceDown) == nil
        )

        #expect(
            AVCaptureVideoOrientation(deviceOrientation: .unknown) == nil
        )
    }

    @Test("Initialise AVCaptureVideoOrientation from InterfaceOrientation")
    func testCastFromInterfaceOrientation() {
        #expect(
            AVCaptureVideoOrientation(interfaceOrientation: .portrait)
            == .portrait
        )
        #expect(
            AVCaptureVideoOrientation(interfaceOrientation: .portraitUpsideDown)
            == .portraitUpsideDown
        )
        #expect(
            AVCaptureVideoOrientation(interfaceOrientation: .landscapeLeft)
            == .landscapeLeft
        )
        #expect(
            AVCaptureVideoOrientation(interfaceOrientation: .landscapeRight)
            == .landscapeRight
        )
        #expect(
            AVCaptureVideoOrientation(interfaceOrientation: .unknown)
            == nil
        )
    }
}
