@testable import GDSCommon
@testable import GDSCommon_Demo
import XCTest

final class GDSListOptionsViewControllerTests: XCTestCase {
    var sut: GDSListOptionsViewController!
    var viewModel: MockListViewModel!

    var screenDidAppear = false
    var didDismiss = false
    
    @MainActor
    override func setUp() {
        super.setUp()
        
        let secondaryButtonViewModel = MockButtonViewModel(title: "Secondary Button") {
            self.didDismiss = true
        }
        
        viewModel = MockListViewModel(secondaryButtonViewModel: secondaryButtonViewModel) {
            self.screenDidAppear = true
        } dismissAction: {
            self.didDismiss = true
        }
        
        sut = .init(viewModel: viewModel)
    }
    
    override func tearDown() {
        viewModel = nil
        sut = nil
        
        screenDidAppear = false
        didDismiss = false
        
        super.tearDown()
    }
    
    @MainActor
    private func setupSUTWithNilOptionals() {
        viewModel = MockListViewModel(secondaryButtonViewModel: nil, listTitle: nil) {
            self.screenDidAppear = true
        } dismissAction: {
            self.didDismiss = true
        }
        
        sut = .init(viewModel: viewModel)
    }
}

extension GDSListOptionsViewControllerTests {
    @MainActor
    func testDidAppear() {
        XCTAssertFalse(screenDidAppear)
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()
        XCTAssertTrue(screenDidAppear)
    }
    
    @MainActor
    func testWillAppear() {
        XCTAssertNil(sut.navigationItem.rightBarButtonItem)
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()
        XCTAssertNotNil(sut.navigationItem.rightBarButtonItem)
    }
    
    @MainActor
    func testVoiceOverFocusElement() throws {
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()
        
        let screen = try XCTUnwrap(sut as VoiceOverFocus)
        let view = try XCTUnwrap(screen.initialVoiceOverView as? UILabel)
        XCTAssertEqual(view.text, "This is the List Options screen pattern")
    }
    
    @MainActor
    func testLabelContents() {
        XCTAssertEqual(try sut.titleLabel.text, "This is the List Options screen pattern")
        XCTAssertEqual(try sut.titleLabel.font, .largeTitleBold)
        XCTAssertEqual(try sut.titleLabel.textColor, .label)
        XCTAssertTrue(try sut.titleLabel.accessibilityTraits.contains(.header))
        
        XCTAssertEqual(try sut.bodyLabel.text, "This is the optional body label. If the view model property is `nil` then the label is hidden.")
        XCTAssertEqual(try sut.bodyLabel.font, .body)
    }
    
    @MainActor
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
    
    @MainActor
    func testPrimaryButton() throws {
        XCTAssertEqual(try sut.primaryButton.backgroundColor, .gdsGreen)
        XCTAssertEqual(try sut.primaryButton.titleLabel?.textColor, .white)
        XCTAssertEqual(try sut.primaryButton.titleLabel?.font, .bodySemiBold)
        XCTAssertEqual(try sut.primaryButton.title(for: .normal), "Action button")
        
        XCTAssertFalse(didDismiss)
        try sut.primaryButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(didDismiss)
    }
    
    @MainActor
    func testDidSelectTableViewSetsSelectedIndex() throws {
        XCTAssertEqual(viewModel.selectedIndex.stringKey, "")
        try sut.tableViewList.reloadData()
        try sut.tableView(sut.tableViewList, didSelectRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(viewModel.selectedIndex.stringKey, "Table view list item 1")
    }
    
    @MainActor
    func testSecondaryButton() throws {
        XCTAssertFalse(try sut.secondaryButton.isHidden)
        
        XCTAssertFalse(didDismiss)
        try sut.secondaryButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(didDismiss)
    }
    
    @MainActor
    func testContentHiddenWhenNil() throws {
        setupSUTWithNilOptionals()
        XCTAssertTrue(try sut.secondaryButton.isHidden)
        XCTAssertTrue(try sut.tableTitleLabel.isHidden)
    }
    
    func testChildViewIsPopulated() throws {
        XCTAssertNotNil(try sut.stackView)
    }
}

// These are also used in `GDSListOptionsV2ViewControllerTests`
// When deprecating `GDSListOptionsViewModel`, move these to the V2 tests
extension GDSListOptionsViewController {
    var titleLabel: UILabel {
        get throws {
            try XCTUnwrap(view[child: "list-title-label"])
        }
    }
    
    var bodyLabel: UILabel {
        get throws {
            try XCTUnwrap(view[child: "list-body-label"])
        }
    }
    
    var tableViewList: UITableView {
        get throws {
            try XCTUnwrap(view[child: "list-table-view"])
        }
    }
    
    var primaryButton: RoundedButton {
        get throws {
            try XCTUnwrap(view[child: "list-primary-button"])
        }
    }
    
    var secondaryButton: SecondaryButton {
        get throws {
            try XCTUnwrap(view[child: "list-secondary-button"])
        }
    }
    
    var stackView: UIStackView {
        get throws {
            try XCTUnwrap(view[child: "list-child-stack-view"])
        }
    }
    
    var tableTitleLabel: UILabel {
        get throws {
            try XCTUnwrap(view[child: "list-table-title"])
        }
    }
}
