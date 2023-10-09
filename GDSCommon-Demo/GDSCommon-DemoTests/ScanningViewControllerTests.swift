import UIKit
import GDSCommon
import XCTest

class MockScanningController: ScanningController {
    public var didCall_completeScan: Bool = false
    public var didCall_completeScanWithError: Bool = false
    
    func completeScan(url: URL) {
        didCall_completeScan = true
    }
    
    func scanCompleteWithError(url: URL?) {
        didCall_completeScanWithError = true
    }
}

final class ScanningViewControllerTests: XCTestCase {
    private var sut: ScanningViewController!
    private var mockScanningController: MockScanningController!
    
    @MainActor
    override func setUp() {
        super.setUp()
        let viewModel = MockQRScanningViewModel()
        mockScanningController = MockScanningController()
        sut = ScanningViewController(scanningController: mockScanningController,
                                     viewModel: viewModel)
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
        sut.scanningController.completeScan(url: URL(string: "testurl")!)
        XCTAssertTrue(mockScanningController.didCall_completeScan)
    }
    
    func test_scanCompleteWithErrors() throws {
        sut.scanningController.scanCompleteWithError(url: URL(string: "testurl"))
        XCTAssertTrue(mockScanningController.didCall_completeScanWithError)
    }
}

extension ScanningViewController {
    var instructionsLabel: UILabel {
        get throws {
            try XCTUnwrap(view[child: "instructionsLabel"])
        }
    }
}

class MockQRScanningViewModel: QRScanningViewModel {
    public var title: String
    public var instructionText: String
    public var successMessage: String
    public var format: String?
    public var shouldShowAlert: Bool
    public var shouldDismissViewAfterScanComplete: Bool
    public var alertTitle: String
    public var alertMessage: String
    public var alertAction: String
    
    init(title: String = "QR Scanning Title",
         instructionText: String = "QR Scanning instruction area, we can instruct the user from here",
         successMessage: String = "QR Code Scanned",
         format: String? = nil,
         shouldShowAlert: Bool = false,
         shouldDismissViewAfterScanComplete: Bool = true,
         alertTitle: String = "QR Code title",
         alertMessage: String = "This code is in the incorrect format",
         alertAction: String = "Ok") {
        self.title = title
        self.instructionText = instructionText
        self.successMessage = successMessage
        self.format = format
        self.shouldShowAlert = shouldShowAlert
        self.shouldDismissViewAfterScanComplete = shouldDismissViewAfterScanComplete
        self.alertTitle = alertTitle
        self.alertMessage = alertMessage
        self.alertAction = alertAction
    }
}
