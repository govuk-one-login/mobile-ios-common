@testable import GDSCommon
@testable import GDSCommon_Demo
import UIKit
import XCTest
import VideoToolbox


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
    
    func test_dectectBarcode() {
        guard let image = UIImage(named: "QRCode"),
        let buffer = buffer(from: image) else { return }
        sut.processOutput(buffer)
    }
}

extension ScanningViewController {
    var instructionsLabel: UILabel {
        get throws {
            try XCTUnwrap(view[child: "instructionsLabel"])
        }
    }
}

extension ScanningViewControllerTests {
    func buffer(from image: UIImage) -> CVPixelBuffer? {
      let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
      var pixelBuffer : CVPixelBuffer?
      let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(image.size.width), Int(image.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
      guard (status == kCVReturnSuccess) else {
        return nil
      }

      CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
      let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)

      let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
      let context = CGContext(data: pixelData, width: Int(image.size.width), height: Int(image.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)

      context?.translateBy(x: 0, y: image.size.height)
      context?.scaleBy(x: 1.0, y: -1.0)

      UIGraphicsPushContext(context!)
      image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
      UIGraphicsPopContext()
      CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))

      return pixelBuffer
    }
}

