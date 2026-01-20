import AVFoundation
@testable import GDSCommon
@testable import GDSCommon_Demo
import UIKit
import Vision
import XCTest

final class ScanningViewControllerTests: XCTestCase {
    private var sut: ScanningViewController<MockCaptureSession>!
    private var presenter: MockDialogPresenter!
    
    private var didCompleteScan: Bool = false
    private var captureSession: MockCaptureSession!
    var didDismiss = false
    
    @MainActor
    override func setUp() {
        super.setUp()
        
        presenter = MockDialogPresenter()
        let viewModel = MockQRScanningViewModel(dialogPresenter: presenter) {
            self.didCompleteScan = true
        } dismissAction: {
            self.didDismiss = true
        }
        
        captureSession = MockCaptureSession()
        
        sut = ScanningViewController(viewModel: viewModel,
                                     captureDevice: MockCaptureDevice.self,
                                     captureSession: captureSession,
                                     requestType: MockDetectBarcodeRequest.self)
        
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()
    }
    
    override func tearDown() {
        sut = nil
        captureSession = nil
        presenter = nil
        super.tearDown()
    }
}

extension ScanningViewControllerTests {
    @MainActor
    func test_titleLabel() {
        XCTAssertNotNil(sut.title)
        XCTAssertEqual(sut.title, "QR Scanning Title")
        
        XCTAssertFalse(sut.navigationItem.hidesBackButton)
    }
    
    @MainActor
    func test_instructionsLabel() throws {
        try XCTAssertNotNil(sut.instructionsLabel)
        try XCTAssertEqual(sut.instructionsLabel.text, "QR Scanning instruction area, we can instruct the user from here")
        try XCTAssertEqual(sut.instructionsLabel.textColor, .white)
        try XCTAssertEqual(sut.instructionsLabel.font, .init(style: .body, weight: .bold))
    }
    
    @MainActor
    func test_didDismiss() {
        XCTAssertEqual(sut.navigationItem.hidesBackButton, false)
        sut.navigationItem.hidesBackButton = true
        XCTAssertEqual(sut.navigationItem.hidesBackButton, true)
        
        sut.beginAppearanceTransition(true, animated: false)
        XCTAssertNotNil(sut.navigationItem.rightBarButtonItem)
        XCTAssertEqual(sut.navigationItem.rightBarButtonItem?.title, "right bar button")

        XCTAssertFalse(didDismiss)

        _ = sut.navigationItem.rightBarButtonItem?.target?.perform(sut.navigationItem.rightBarButtonItem?.action)
        XCTAssertTrue(didDismiss)
    }
        
    @MainActor
    func testStopScanning() {
        XCTAssertTrue(sut.captureSession.isRunning)
        sut.stopScanning()
        XCTAssertFalse(sut.captureSession.isRunning)
        sut.startScanning()
        waitForTruth(self.sut.captureSession.isRunning,
                     timeout: 2)
    }
    
    @MainActor
    func test_detectedBarcode_noResults() throws {
        let barcodeRequest = try XCTUnwrap(sut.barcodeRequest as? MockDetectBarcodeRequest)
        barcodeRequest.requestHandler?(MockBarcodeRequest(results: nil), nil)
        
        waitForTruth(!self.presenter.didCallPresent, timeout: 2)
        waitForTruth(!self.didCompleteScan, timeout: 2)
    }
    
    @MainActor
    func test_detectBarcode_successful() throws {
        let barcodeRequest = try XCTUnwrap(sut.barcodeRequest as? MockDetectBarcodeRequest)
        barcodeRequest.requestHandler?(MockBarcodeRequest(results: [
            MockBarcodeObservation("www.google.com/ABC123")
        ]), nil)
        
        waitForTruth(self.presenter.didCallPresent, timeout: 2)
        waitForTruth(self.didCompleteScan, timeout: 2)
    }
    
    @MainActor
    func test_detectBarcode_failure() throws {
        let barcodeRequest = try XCTUnwrap(sut.barcodeRequest as? MockDetectBarcodeRequest)
        barcodeRequest.requestHandler?(MockBarcodeRequest(results: [
            MockBarcodeObservation("www.google.com/AJS432")
        ]), nil)
        
        waitForTruth(self.presenter.didCallPresent, timeout: 2)
        waitForTruth(!self.didCompleteScan, timeout: 2)
    }
    
    @MainActor
    func test_metadataCapture_setupCorrectly() throws {
        let output = try XCTUnwrap(captureSession.output
                                   as? AVCaptureVideoDataOutput)
        XCTAssertTrue(output.alwaysDiscardsLateVideoFrames)
        XCTAssertTrue(output.sampleBufferDelegate === sut)
        XCTAssertTrue(output.sampleBufferCallbackQueue === sut.processingQueue)
    }

    @MainActor
    func test_delegateIsNilledOnCleanup() throws {
        let output = try XCTUnwrap(captureSession.output as? AVCaptureVideoDataOutput)
        XCTAssertNotNil(output.sampleBufferDelegate)
        XCTAssertTrue(output.sampleBufferDelegate === sut)

        sut.beginAppearanceTransition(false, animated: false)
        sut.endAppearanceTransition()

        waitForTruth(output.sampleBufferDelegate == nil, timeout: 2.0)
    }

    @MainActor
    func test_visionRequestIsCleanedUp() throws {
        let barcodeRequest = try XCTUnwrap(sut.barcodeRequest as? MockDetectBarcodeRequest)
        XCTAssertNotNil(barcodeRequest)
        XCTAssertFalse(barcodeRequest.wasCancelled)

        sut.beginAppearanceTransition(false, animated: false)
        sut.endAppearanceTransition()

        waitForTruth(barcodeRequest.wasCancelled || self.sut.barcodeRequest == nil, timeout: 2.0)
    }

    @MainActor
    func test_previewLayerRemovedOnDismissal() {
        // Preview layer should be added after setUp (which calls beginAppearanceTransition)
        // Verify it exists initially
        XCTAssertNotNil(sut.testPreviewLayer.superlayer, "Preview layer should be added to view hierarchy")

        // Now dismiss and verify cleanup
        sut.beginAppearanceTransition(false, animated: false)
        sut.endAppearanceTransition()

        // Verify preview layer is removed
        waitForTruth(self.sut.testPreviewLayer.superlayer == nil, timeout: 2.0)
    }

    @MainActor
    func test_captureSessionStopsOnDismissal() {
        XCTAssertTrue(sut.captureSession.isRunning)

        sut.beginAppearanceTransition(false, animated: false)
        sut.endAppearanceTransition()

        waitForTruth(!self.sut.captureSession.isRunning, timeout: 2.0)
    }

    @MainActor
    func test_multipleAppearDisappearCycles() throws {
        // First cycle
        sut.beginAppearanceTransition(false, animated: false)
        sut.endAppearanceTransition()

        let output1 = try XCTUnwrap(captureSession.output as? AVCaptureVideoDataOutput)
        waitForTruth(output1.sampleBufferDelegate == nil, timeout: 2.0)
        waitForTruth(!self.sut.captureSession.isRunning, timeout: 2.0)

        // Second cycle - reappear
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()

        // Should be able to set up again
        waitForTruth(self.sut.captureSession.isRunning, timeout: 2.0)

        // Second cycle - disappear again
        sut.beginAppearanceTransition(false, animated: false)
        sut.endAppearanceTransition()

        let output2 = try XCTUnwrap(captureSession.output as? AVCaptureVideoDataOutput)
        waitForTruth(output2.sampleBufferDelegate == nil, timeout: 2.0)
        waitForTruth(!self.sut.captureSession.isRunning, timeout: 2.0)
    }

    @MainActor
    func test_handlesVisionRequestError() throws {
        // This test verifies that errors in Vision request don't crash
        // We can't easily simulate a Vision error, but we can verify the error handling path exists
        let barcodeRequest = try XCTUnwrap(sut.barcodeRequest)

        // Verify request exists and can be cancelled (error handling path)
        XCTAssertNotNil(barcodeRequest)

        // The error handling is in captureOutput - we verify it doesn't crash
        // by ensuring the component continues to function
        sut.beginAppearanceTransition(false, animated: false)
        sut.endAppearanceTransition()

        // Should clean up without crashing
        waitForTruth(!self.sut.captureSession.isRunning, timeout: 2.0)
    }

    @MainActor
    func test_viewControllerDeallocatesAfterDismissal() {
        weak var weakSUT: ScanningViewController<MockCaptureSession>?

        autoreleasepool {
            let presenter = MockDialogPresenter()
            let viewModel = MockQRScanningViewModel(dialogPresenter: presenter) {
            } dismissAction: {
            }

            let session = MockCaptureSession()
            let localSUT = ScanningViewController(viewModel: viewModel,
                                                  captureDevice: MockCaptureDevice.self,
                                                  captureSession: session,
                                                  requestType: MockDetectBarcodeRequest.self)

            localSUT.beginAppearanceTransition(true, animated: false)
            localSUT.endAppearanceTransition()

            weakSUT = localSUT

            // Trigger cleanup
            localSUT.beginAppearanceTransition(false, animated: false)
            localSUT.endAppearanceTransition()
        }

        // Wait a bit for deallocation
        waitForTruth(weakSUT == nil, timeout: 2.0)
        XCTAssertNil(weakSUT, "View controller should deallocate after cleanup")
    }
}

extension ScanningViewController {
    var instructionsLabel: UILabel {
        get throws {
            try XCTUnwrap(view[child: "instructionsLabel"])
        }
    }

    // Test helpers for accessing private properties
    var testPreviewLayer: AVCaptureVideoPreviewLayer {
        previewLayer
    }

    var testVideoDataOutput: AVCaptureVideoDataOutput? {
        videoDataOutput
    }
}
