@testable import GDSCommon
import UIKit
import XCTest

final class ScanOverlayViewTests: XCTestCase {
    var sut: ScanOverlayView!
    let size: CGFloat = 100
    
    override func setUp() {
        super.setUp()
        
        sut = .init(frame: .init(x: 0, y: 0,
                                 width: size, height: size))
        
    }
    
    override func tearDown() {
        super.tearDown()
        
        sut = nil
    }
}

extension ScanOverlayViewTests {
    func testViewfinderSizes() {
        XCTAssertEqual(sut.reticleInset, size / 10)
        XCTAssertEqual(sut.viewfinderRect,
                       CGRect(x: 15, y: 15, width: 70, height: 70))
    }
}
