@testable import GDSCommon
import XCTest

final class OrientationLockingTabBarControllerTests: XCTestCase {
    private var sut: OrientationLockingTabBarController!
    private var navigationController: UINavigationController!
    private var orientationLockingViewController: OrientationLockingViewController!
    private var viewController: UIViewController!
    
    override func setUp() {
        super.setUp()
        sut = OrientationLockingTabBarController()
        navigationController = UINavigationController()
        orientationLockingViewController = MockOrientationLockingViewController()
        viewController = UIViewController()
        
        sut.setViewControllers([navigationController], animated: true)
        attachToWindow(viewController: sut)
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
    func test_shouldNotAutorotate() {
        sut.selectedViewController = navigationController
        orientationLockingViewController = MockOrientationLockingViewController(shouldAutorotate: false)
        
        // Present OrientationLockingViewController modally
        navigationController.present(orientationLockingViewController, animated: false)
        
        // TabBarController rotation should match MockOrientationLockingViewController rotation
        XCTAssertEqual(sut.shouldAutorotate, false)
    }
    
    func test_shouldAutorotate() {
        sut.selectedViewController = navigationController
        orientationLockingViewController = MockOrientationLockingViewController(shouldAutorotate: true)
        
        // Present OrientationLockingViewController modally
        navigationController.present(orientationLockingViewController, animated: true)
        
        // TabBarController rotation should match MockOrientationLockingViewController rotation
        XCTAssertEqual(sut.shouldAutorotate, true)
    }
    
    func test_preferredInterfaceOrientationForPresentation() {
        sut.selectedViewController = navigationController
        
        // Present OrientationLockingViewController modally
        navigationController.present(orientationLockingViewController, animated: false)
        
        // TabBarController rotation should match MockOrientationLockingViewController rotation
        XCTAssertEqual(sut.preferredInterfaceOrientationForPresentation, .landscapeLeft)
    }
    
    func test_supportedInterfaceOrientations() {
        sut.selectedViewController = navigationController
        
        // Present OrientationLockingViewController modally
        navigationController.present(orientationLockingViewController, animated: false)
        
        // TabBarController rotation should match MockOrientationLockingViewController rotation
        XCTAssertEqual(sut.supportedInterfaceOrientations, .landscapeLeft)
    }
    
    func test_preferredStatusBarStyle() {
        sut.selectedViewController = navigationController
        
        // Present OrientationLockingViewController modally
        navigationController.present(orientationLockingViewController, animated: false)
        
        // TabBarController rotation should match MockOrientationLockingViewController rotation
        XCTAssertEqual(sut.preferredStatusBarStyle, .darkContent)
    }
}

// Result of OrientationLockingTabBarController should match default behaviour of UITabBarController
extension OrientationLockingTabBarControllerTests {
    func test_default_shouldAutorotate() {
        sut.selectedViewController = navigationController
        
        // Present a UIViewController modally
        navigationController.present(viewController, animated: false)
        
        XCTAssertEqual(sut.shouldAutorotate, UITabBarController().shouldAutorotate)
    }
    
    func test_default_preferredInterfaceOrientationForPresentation() {
        sut.selectedViewController = navigationController
        
        // Present a UIViewController modally
        navigationController.present(viewController, animated: false)
        
        // Since the UIViewController is being presented modally
        // This value value will not be set and will be .unknown
        XCTAssertEqual(sut.preferredInterfaceOrientationForPresentation, .unknown)
    }
    
    func test_default_supportedInterfaceOrientations() {
        sut.selectedViewController = navigationController
        
        // Present a UIViewController modally
        navigationController.present(viewController, animated: false)
        
        XCTAssertEqual(sut.supportedInterfaceOrientations, UITabBarController().supportedInterfaceOrientations)
    }
    
    func test_default_preferredStatusBarStyle() {
        sut.selectedViewController = navigationController
        
        // Present a UIViewController modally
        navigationController.present(viewController, animated: false)
        
        XCTAssertEqual(sut.preferredStatusBarStyle, UITabBarController().preferredStatusBarStyle)
    }
}

class MockOrientationLockingViewController: UINavigationController, OrientationLockingViewController {
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
