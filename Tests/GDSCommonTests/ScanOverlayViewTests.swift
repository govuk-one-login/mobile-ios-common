@testable import GDSCommon
import UIKit
import XCTest

final class ScanOverlayViewTests: XCTestCase {
    var sut: ScanOverlayView!
    let size: CGFloat = 100
    
    var parentView: UIView {
        let size = CGSize(width: 300, height: 800)
        return UIView(frame: .init(origin: .zero, size: size))
    }
    
    override func setUp() {
        super.setUp()
        
        sut = .init(frame: .init(x: 0, y: 0,
                                 width: size, height: size * 2))

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
                       CGRect(x: 15, y: 65, width: 70, height: 70))
    }

    func testViewfinderSizesLandscape() {
        struct LandscapeOrientationProvider: OrientationProvider {
            let orientation: UIDeviceOrientation = .landscapeLeft
        }
        sut.orientationProvider = LandscapeOrientationProvider()

        XCTAssertEqual(sut.reticleInset, size / 5)
        XCTAssertEqual(sut.viewfinderRect,
                       CGRect(x: 30, y: 80, width: 40, height: 40))
    }

    func testWillMoveToView() {
        parentView.addSubview(sut)
        
        XCTAssertEqual(sut.overlayLayer.fillRule, .evenOdd)
        XCTAssertEqual(sut.overlayLayer.opacity, 0.5)
        XCTAssertTrue(sut.layer.sublayers?.contains(sut.overlayLayer) ?? false)
    }
    
    func testLayoutSubviews() {
        sut.layoutSubviews()
        XCTAssertEqual(sut.overlayLayer.frame, sut.frame)
    }
}
