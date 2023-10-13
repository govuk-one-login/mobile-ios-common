@testable import GDSCommon
@testable import GDSCommon_Demo
import UIKit
import XCTest

final class ScanningViewControllerTests: XCTestCase {
    private var sut: ScanningViewController!
    private var presenter: MockDialogPresenter!
    
    private var didCompleteScan: Bool = false
    
    @MainActor
    override func setUp() {
        super.setUp()
        
        presenter = MockDialogPresenter()
        let viewModel = MockQRScanningViewModel(dialogPresenter: presenter) {
            self.didCompleteScan = true
        }
 
        sut = ScanningViewController(viewModel: viewModel)
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
    
    func testStopScanning() {
        XCTAssertFalse(sut.captureSession.isRunning)
        sut.startScanning()
        
        waitForTruth(self.sut.captureSession.isRunning,
                     timeout: 2)
        sut.stopScanning()
        XCTAssertFalse(sut.captureSession.isRunning)
        
    }
    
    func test_dectectBarcode_successful() async {
        await sut.didScan(string: "www.google.com/ABC123")
        waitForTruth(self.presenter.didCallPresent, timeout: 2)
        waitForTruth(self.didCompleteScan, timeout: 2)
    }
    
    func test_dectectBarcode_failure() async {
        await sut.didScan(string: "www.google.com/AJS432")
        waitForTruth(self.presenter.didCallPresent, timeout: 2)
        waitForTruth(!self.didCompleteScan, timeout: 2)
    }
}

extension ScanningViewController {
    var instructionsLabel: UILabel {
        get throws {
            try XCTUnwrap(view[child: "instructionsLabel"])
        }
    }
}
