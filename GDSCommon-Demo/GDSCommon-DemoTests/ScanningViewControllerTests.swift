@testable import GDSCommon
@testable import GDSCommon_Demo
import UIKit
import XCTest
import VideoToolbox


class MockScanningController: ScanningController {
    public var didCall_completeScan: Bool = false
    public var didCall_completeScanWithError: Bool = false
    
    func completeScan(url: URL?, didFinishWithError: Bool) {
        if didFinishWithError {
            didCall_completeScanWithError = true
        } else {
            didCall_completeScan = true
        }
    }
}

final class ScanningViewControllerTests: XCTestCase {
    private var sut: ScanningViewController!
    private var mockScanningController: MockScanningController!
    private var presenter: MockDialogPresenter!
    
    @MainActor
    override func setUp() {
        super.setUp()
        let viewModel = MockQRScanningViewModel()
        presenter = MockDialogPresenter()
        mockScanningController = MockScanningController()
        sut = ScanningViewController(scanningController: mockScanningController,
                                     viewModel: viewModel,
                                     presenter: presenter)
        sut.loadViewIfNeeded()
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
    }
    
    func test_nibName() throws {
        XCTAssertNotNil(sut.nibName)
        XCTAssertEqual(sut.nibName, "Scanner")
    }
    
    func test_scanComplete() throws {
        sut.scanningController.completeScan(url: URL(string: "ABC123")!, didFinishWithError: false)
        XCTAssertTrue(mockScanningController.didCall_completeScan)
    }
    
    func test_scanCompleteWithErrors() throws {
        sut.scanningController.completeScan(url: URL(string: "ABS125")!, didFinishWithError: true)
        XCTAssertTrue(mockScanningController.didCall_completeScanWithError)
    }
    
    func test_dectectBarcode_successful() {
        sut.handleBarcode(qrCode: "www.google.com/ABC123")
        waitForTruth(self.presenter.didCallPresent, timeout: 2)
        waitForTruth(self.mockScanningController.didCall_completeScan, timeout: 2)
    }
    
    func test_dectectBarcode_failure() {
        sut.handleBarcode(qrCode: "www.google.com/AJS432")
        waitForTruth(self.presenter.didCallPresent, timeout: 2)
        waitForTruth(self.mockScanningController.didCall_completeScanWithError, timeout: 2)
    }
}

extension ScanningViewController {
    var instructionsLabel: UILabel {
        get throws {
            try XCTUnwrap(view[child: "instructionsLabel"])
        }
    }
}
