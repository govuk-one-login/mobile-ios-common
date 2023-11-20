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
        super.tearDown()
    }
    
    
    func test_titleLabel() throws {
        XCTAssertNotNil(sut.title)
        XCTAssertEqual(sut.title, "QR Scanning Title")
    }
    
    func test_instructionsLabel() throws {
        try XCTAssertNotNil(sut.instructionsLabel)
        try XCTAssertEqual(sut.instructionsLabel.text, "QR Scanning instruction area, we can instruct the user from here")
        try XCTAssertEqual(sut.instructionsLabel.textColor, .white)
        try XCTAssertEqual(sut.instructionsLabel.font, .init(style: .body, weight: .bold))
    }
    
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
    
    func test_nibName() throws {
        XCTAssertNotNil(sut.nibName)
        XCTAssertEqual(sut.nibName, "Scanner")
    }
    
    func testStopScanning() {
        XCTAssertTrue(sut.captureSession.isRunning)
        sut.stopScanning()
        XCTAssertFalse(sut.captureSession.isRunning)
        sut.startScanning()
        waitForTruth(self.sut.captureSession.isRunning,
                     timeout: 2)
    }
    
    func test_detectedBarcode_noResults() throws {
        let barcodeRequest = try XCTUnwrap(sut.barcodeRequest as? MockDetectBarcodeRequest)
        barcodeRequest.requestHandler?(MockBarcodeRequest(results: nil), nil)
        
        waitForTruth(!self.presenter.didCallPresent, timeout: 2)
        waitForTruth(!self.didCompleteScan, timeout: 2)
    }
    
    func test_detectBarcode_successful() throws {
        let barcodeRequest = try XCTUnwrap(sut.barcodeRequest as? MockDetectBarcodeRequest)
        barcodeRequest.requestHandler?(MockBarcodeRequest(results: [
            MockBarcodeObservation("www.google.com/ABC123")
        ]), nil)
        
        waitForTruth(self.presenter.didCallPresent, timeout: 2)
        waitForTruth(self.didCompleteScan, timeout: 2)
    }
    
    func test_detectBarcode_failure() throws {
        let barcodeRequest = try XCTUnwrap(sut.barcodeRequest as? MockDetectBarcodeRequest)
        barcodeRequest.requestHandler?(MockBarcodeRequest(results: [
            MockBarcodeObservation("www.google.com/AJS432")
        ]), nil)
        
        waitForTruth(self.presenter.didCallPresent, timeout: 2)
        waitForTruth(!self.didCompleteScan, timeout: 2)
    }
    
    func test_metadataCapture_setupCorrectly() throws {
        let output = try XCTUnwrap(captureSession.output
                                   as? AVCaptureVideoDataOutput)
        XCTAssertTrue(output.alwaysDiscardsLateVideoFrames)
        XCTAssertTrue(output.sampleBufferDelegate === sut)
        XCTAssertTrue(output.sampleBufferCallbackQueue === sut.processingQueue)
    }
}

extension ScanningViewController {
    var instructionsLabel: UILabel {
        get throws {
            try XCTUnwrap(view[child: "instructionsLabel"])
        }
    }
}
