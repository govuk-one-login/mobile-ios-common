@testable import GDSCommon
import XCTest

final class OrientationLockingTabBarControllerTests: XCTestCase {
    private var sut: OrientationLockingTabBarController!
    private var navigationController: UINavigationController!
    private var orientationLockingViewController: OrientationLockingNavigationController!
    private var viewController: UIViewController!
    
    override func setUp() {
        super.setUp()
        sut = OrientationLockingTabBarController()
        navigationController = UINavigationController()
        orientationLockingViewController = MockOrientationLockingViewController(shouldAutorotate: false)
        viewController = UIViewController()
        
        sut.viewControllers = [navigationController]
    }
    
    override func tearDown() {
        orientationLockingViewController = nil
        viewController = nil
        sut = nil
        super.tearDown()
    }
}

// Result of OrientationLockingTabBarController should match OrientationLockingViewController
extension OrientationLockingTabBarControllerTests {
    func test_shouldAutorotate_IDCheckNavigationControllerSelected() {
        sut.selectedViewController = navigationController
        
        // Present OrientationLockingViewController modally
        navigationController.present(orientationLockingViewController, animated: true)
        
        let result = sut.shouldAutorotate
        XCTAssertEqual(result, false)
    }
    
    func test_preferredInterfaceOrientationForPresentation_IDCheckNavigationControllerSelected() {
        sut.selectedViewController = navigationController
        
        // Present OrientationLockingViewController modally
        navigationController.present(orientationLockingViewController, animated: false)
        
        let result = sut.preferredInterfaceOrientationForPresentation
        XCTAssertEqual(result, orientationLockingViewController.preferredInterfaceOrientationForPresentation)
    }
    
    func test_supportedInterfaceOrientations_IDCheckNavigationControllerSelected() {
        sut.selectedViewController = navigationController
        
        // Present OrientationLockingViewController modally
        navigationController.present(orientationLockingViewController, animated: false)
        
        let result = sut.supportedInterfaceOrientations
        XCTAssertEqual(result, orientationLockingViewController.supportedInterfaceOrientations)
    }
    
    func test_preferredStatusBarStyle_IDCheckNavigationControllerSelected() {
        sut.selectedViewController = navigationController
        
        // Present OrientationLockingViewController modally
        navigationController.present(orientationLockingViewController, animated: false)
        
        let result = sut.preferredStatusBarStyle
        XCTAssertEqual(result, orientationLockingViewController.preferredStatusBarStyle)
    }
}

// Result of OrientationLockingTabBarController should match default behaviour of UITabBarController
 extension OrientationLockingTabBarControllerTests {
    func test_shouldAutorotate_OtherViewControllerPresented() {
        sut.selectedViewController = navigationController
        
        // Present a UIViewController modally
        navigationController.present(viewController, animated: false)
        
        let result = sut.shouldAutorotate
        XCTAssertEqual(result, UITabBarController().shouldAutorotate)
    }
    
    func test_preferredInterfaceOrientationForPresentation_OtherViewControllerPresented() {
        sut.selectedViewController = navigationController
        
        // Present a UIViewController modally
        navigationController.present(viewController, animated: false)
        
        let result = sut.preferredInterfaceOrientationForPresentation
        XCTAssertEqual(result, UITabBarController().preferredInterfaceOrientationForPresentation)
    }
    
    func test_supportedInterfaceOrientations_OtherViewControllerPresented() {
        sut.selectedViewController = navigationController
        
        // Present a UIViewController modally
        navigationController.present(viewController, animated: false)
        
        let result = sut.supportedInterfaceOrientations
        XCTAssertEqual(result, UITabBarController().supportedInterfaceOrientations)
    }
    
    func test_preferredStatusBarStyle_OtherViewControllerPresented() {
        sut.selectedViewController = navigationController
        
        // Present a UIViewController modally
        navigationController.present(viewController, animated: false)
        
        let result = sut.preferredStatusBarStyle
        XCTAssertEqual(result, UITabBarController().preferredStatusBarStyle)
    }
 }

class MockOrientationLockingViewController: UINavigationController, OrientationLockingNavigationController {
    let shouldAutorotateValue: Bool
    
    init(shouldAutorotate: Bool = false) {
        shouldAutorotateValue = shouldAutorotate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var shouldAutorotate: Bool {
        shouldAutorotateValue
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        .landscapeLeft
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .landscapeLeft
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
}
