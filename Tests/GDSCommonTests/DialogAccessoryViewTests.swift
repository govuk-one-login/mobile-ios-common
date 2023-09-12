@testable import GDSCommon
import XCTest

final class CheckmarkDialogAccessoryViewTests: XCTestCase {

    private var sut: CheckmarkDialogAccessoryView!
    private var viewController: UIViewController!
    private var window: UIWindow!
    
    override func setUp() {
        super.setUp()
        sut = .init()
        
        viewController = .init()
        
        window = UIWindow()
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
    
    override func tearDown() {
        window = nil
        viewController = nil
        super.tearDown()
    }
    
    func test_instantiation() {
        XCTAssertNil(sut.checkmarkLayer)
    }
    
    func test_sublayerInstantiation() {
        viewController.view.addSubview(sut)
        sut.layoutSubviews()
        XCTAssertNotNil(sut.checkmarkLayer)
    }
    
    func test_checkmarkLayer() {
        sut.layoutSubviews()
        guard let checkmarkLayer = sut.checkmarkLayer else {
            XCTFail("Checkmark layer should not be nil")
            return
        }
        checkmarkLayer.playAnimation()
        XCTAssertEqual(checkmarkLayer.tickLayer.superlayer, checkmarkLayer.drawingLayer)
        XCTAssertEqual(checkmarkLayer.tickLayer.lineCap, .round)
        XCTAssertNil(checkmarkLayer.tickLayer.fillColor)
        guard let animationKeys = checkmarkLayer.tickLayer.animationKeys() else {
            XCTFail("Checkmark layer should have animation keys in progress")
            return
        }
        XCTAssertTrue(animationKeys.contains("strokeEnd"))
    }
}
