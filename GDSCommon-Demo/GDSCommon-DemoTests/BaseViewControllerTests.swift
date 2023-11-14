@testable import GDSCommon
import GDSCommon_Demo
import XCTest

final class BaseViewControllerTests: XCTestCase {
    var viewModel: BaseViewModel!
    var sut: BaseViewController!
    
    override func setUp() {
        super.setUp()
        viewModel = MockBaseViewModel {
            
        } dismissAction: {
            
        }
        sut = BaseViewController(viewModel: viewModel, nibName: "MockBase", bundle: .init(for: BaseViewControllerTests.self))
    }
    
    override func tearDown() {
        viewModel = nil
        sut = nil
        
        super.tearDown()
    }
}

extension BaseViewControllerTests {
    func test_labelContents() throws {
        dump(sut)
        sut.beginAppearanceTransition(true, animated: false)
        sut.viewDidAppear(false)
        sut.endAppearanceTransition()
        let rightBarButton: UIBarButtonItem = try XCTUnwrap(sut.navigationItem.rightBarButtonItem)
        XCTAssertEqual(rightBarButton.title, "right bar button")
    }
}
