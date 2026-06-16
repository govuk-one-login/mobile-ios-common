import AVFoundation
@testable import GDSCommon
import UIKit
import Vision
import XCTest

final class ScanningViewControllerErrorHandlerTests: XCTestCase {
    private var capturedError: Error?
    private var errorHandlerCallCount = 0

    @MainActor
    func test_errorHandlerCalledWhenCaptureDeviceUnavailable() {
        let viewModel = StubScanningViewModel()

        let sut = ScanningViewController(
            viewModel: viewModel,
            captureDevice: UnavailableCaptureDevice.self,
            captureSession: StubCaptureSession(),
            requestType: VNDetectBarcodesRequest.self,
            errorHandler: { [unowned self] error in
                self.errorHandlerCallCount += 1
                self.capturedError = error
            }
        )

        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()

        XCTAssertGreaterThan(errorHandlerCallCount, 0)
        XCTAssertNil(capturedError)
    }

    @MainActor
    func test_errorHandlerNotCalledDuringNormalOperation() {
        let viewModel = StubScanningViewModel()
        let session = StubCaptureSession()

        let sut = ScanningViewController(
            viewModel: viewModel,
            captureDevice: StubCaptureDevice.self,
            captureSession: session,
            requestType: VNDetectBarcodesRequest.self,
            errorHandler: { [unowned self] error in
                self.errorHandlerCallCount += 1
                self.capturedError = error
            }
        )

        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()

        sut.beginAppearanceTransition(false, animated: false)
        sut.endAppearanceTransition()

        XCTAssertEqual(errorHandlerCallCount, 0)
    }
}

// MARK: - Test Doubles

private final class StubCaptureSession: CaptureSession {
    var layer: AVCaptureVideoPreviewLayer { AVCaptureVideoPreviewLayer() }
    var isRunning: Bool = false
    func startRunning() { isRunning = true }
    func stopRunning() { isRunning = false }
    func beginConfiguration() {}
    func commitConfiguration() {}
    func canAddInput(_ input: StubCaptureDeviceInput) -> Bool { true }
    func addInput(_ input: StubCaptureDeviceInput) {}
    func canAddOutput(_ output: AVCaptureOutput) -> Bool { true }
    func addOutput(_ output: AVCaptureOutput) {}
}

private struct StubCaptureDeviceInput {}

private final class StubCaptureDevice: CaptureDevice {
    static func `for`(mediaType: AVMediaType) -> Self? { Self() }
    var input: StubCaptureDeviceInput { get throws { StubCaptureDeviceInput() } }
}

private final class UnavailableCaptureDevice: CaptureDevice {
    static func `for`(mediaType: AVMediaType) -> Self? { nil }
    var input: StubCaptureDeviceInput { get throws { StubCaptureDeviceInput() } }
}

private final class StubDialogPresenter: DialogPresenter {
    func present(onView view: UIView, shouldLoad: Bool?, title: String?) async {}
    func updateState(isLoading: Bool, newTitle: String, view: UIView) async {}
    func remove(view: UIView) async {}
}

private final class StubScanningViewModel: QRScanningViewModel {
    let title = "Test"
    let instructionText = "Test"
    func didScan(value: String, in view: UIView) async {}
}
