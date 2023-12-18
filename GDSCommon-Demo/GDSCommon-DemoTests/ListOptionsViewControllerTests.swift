@testable import GDSCommon
@testable import GDSCommon_Demo
import XCTest

final class ListOptionsViewControllerTests: XCTestCase {
    var sut: ListOptionsViewController!
    var viewModel: ListOptionsViewModel!
    var resultAction: ((GDSLocalisedString) -> Void)!

    var didSetStringKey: String?
    var screenDidAppear: Bool!
    var didDismiss: Bool!
    
    override func setUp() {
        super.setUp()
        screenDidAppear = false
        didDismiss = false
        
        resultAction = { gdsString in
            self.didSetStringKey = gdsString.stringKey
        }
        
        viewModel = MockListViewModel { localisedString in
            self.didSetStringKey = localisedString.stringKey
        } screenView: {
            self.screenDidAppear = true
        } dismissAction: {
            self.didDismiss = true
        }
        sut = .init(viewModel: viewModel)
    }
    
    override func tearDown() {
        screenDidAppear = nil
        didDismiss = nil
        resultAction = nil
        viewModel = nil
        sut = nil
        
        super.tearDown()
    }
}

extension ListOptionsViewControllerTests {
    func testDidAppear() {
        XCTAssertFalse(screenDidAppear)
        sut.beginAppearanceTransition(true, animated: false)
        sut.viewDidAppear(false)
        sut.endAppearanceTransition()
        XCTAssertTrue(screenDidAppear)
    }
    
    func testWillAppear() {
        XCTAssertNil(sut.navigationItem.rightBarButtonItem)
        sut.beginAppearanceTransition(true, animated: false)
        sut.viewDidAppear(false)
        sut.endAppearanceTransition()
        sut.viewDidAppear(false)
        XCTAssertNotNil(sut.navigationItem.rightBarButtonItem)
    }
    
    func testVoiceOverFocusElement() throws {
        sut.beginAppearanceTransition(true, animated: false)
        sut.viewDidAppear(false)
        sut.endAppearanceTransition()
        
        let screen = try XCTUnwrap(sut as VoiceOverFocus)
        let view = try XCTUnwrap(screen.initialVoiceOverView as? UILabel)
        XCTAssertEqual(view.text, "This is the List Options screen pattern")
    }
    
    func testLabelContents() {
        XCTAssertEqual(try sut.titleLabel.text, "This is the List Options screen pattern")
        XCTAssertEqual(try sut.titleLabel.font, .largeTitleBold)
        XCTAssertEqual(try sut.titleLabel.textColor, .label)
        XCTAssertTrue(try sut.titleLabel.accessibilityTraits.contains(.header))
        
        XCTAssertEqual(try sut.bodyLabel.text, "This is the optional body label. If the view model property is `nil` then the label is hidden.")
        XCTAssertEqual(try sut.bodyLabel.font, .body)
    }
    
    func testTitleBar() {
        XCTAssertEqual(sut.navigationItem.hidesBackButton, false)
        sut.navigationItem.hidesBackButton = true
        XCTAssertEqual(sut.navigationItem.hidesBackButton, true)
        
        sut.beginAppearanceTransition(true, animated: false)
        XCTAssertNotNil(sut.navigationItem.rightBarButtonItem)
        XCTAssertEqual(sut.navigationItem.rightBarButtonItem?.title, "Right bar button")

        XCTAssertFalse(didDismiss)

        _ = sut.navigationItem.rightBarButtonItem?.target?.perform(sut.navigationItem.rightBarButtonItem?.action)
        XCTAssertTrue(didDismiss)
    }
    
    func testPrimaryButton() throws {
        XCTAssertEqual(try sut.primaryButton.backgroundColor, .gdsGreen)
        XCTAssertEqual(try sut.primaryButton.titleLabel?.textColor, .white)
        XCTAssertEqual(try sut.primaryButton.titleLabel?.font, .bodySemiBold)
        XCTAssertEqual(try sut.primaryButton.title(for: .normal), "Action button")

        try sut.tableViewList.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .none)
        
        XCTAssertNil(didSetStringKey)
        try sut.primaryButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(didSetStringKey, "Table view list item 1")
    }
}

extension ListOptionsViewController {
    var titleLabel: UILabel {
        get throws {
            try XCTUnwrap(view[child: "titleLabel"])
        }
    }
    
    var bodyLabel: UILabel {
        get throws {
            try XCTUnwrap(view[child: "bodyLabel"])
        }
    }
    
    var tableViewList: UITableView {
        get throws {
            try XCTUnwrap(view[child: "tableViewList"])
        }
    }
    
    var primaryButton: RoundedButton {
        get throws {
            try XCTUnwrap(view[child: "primaryButton"])
        }
    }
}
