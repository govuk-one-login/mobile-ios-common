@testable import GDSCommon
@testable import GDSCommon_Demo
import XCTest

final class GDSListOptionsV2ViewControllerTests: XCTestCase {
    var sut: GDSListOptionsViewController!
    var viewModel: MockListViewModelV2!

    var screenDidAppear = false
    var didDismiss = false

    @MainActor
    override func setUp() {
        super.setUp()

        let secondaryButtonViewModel = MockButtonViewModel(title: "Secondary Button") {
            self.didDismiss = true
        }

        viewModel = MockListViewModelV2(secondaryButtonViewModel: secondaryButtonViewModel) {
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
        viewModel = MockListViewModelV2(secondaryButtonViewModel: nil, listTitle: nil) {
            self.screenDidAppear = true
        } dismissAction: {
            self.didDismiss = true
        }

        sut = .init(viewModel: viewModel)
    }
}

extension GDSListOptionsV2ViewControllerTests {
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
        let cell = try sut.tableView(sut.tableViewList, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(cell.accessibilityHint, ", option 1 of 2")
        XCTAssertEqual(cell.textLabel?.text, viewModel.listRows[0].title.stringKey)
        XCTAssertEqual(cell.accessibilityTraits, .button)
        XCTAssertEqual(cell.accessibilityLabel, "Table view list item 1")
        XCTAssertEqual(viewModel.listRows[0].accessibilityLabel, "Table view list item 1")
        XCTAssertEqual(viewModel.listRows[0].accessibilityTraits, .button)
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
