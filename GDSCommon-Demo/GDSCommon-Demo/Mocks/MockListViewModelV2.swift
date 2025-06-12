import GDSCommon
import UIKit

struct MockListCellViewModel: GDSListCellViewModel {
    let title: GDSLocalisedString
    let action: () -> Void
    let accessibilityLabel: String
    let accessibilityTraits: UIAccessibilityTraits = .button

    init(title: GDSLocalisedString,
         accessibilityLabel: String,
         action: @escaping () -> Void) {
        self.title = title
        self.action = action
        self.accessibilityLabel = accessibilityLabel
    }
}

class MockListViewModelV2: GDSListOptionsViewModelV2, BaseViewModel {
    let title: GDSLocalisedString = "This is the List Options screen pattern"
    let body: GDSLocalisedString? = "This is the optional body label. If the view model property is `nil` then the label is hidden."
    var childView: UIView? {
        let bodyLabel = UILabel()
        // swiftlint:disable line_length
        bodyLabel.text = GDSLocalisedString(stringLiteral: "This is a body label inside the optional childView. This childView has no layout margins, add right and left margins of 16 points programtically if required").value
        // swiftlint:enable line_length
        bodyLabel.numberOfLines = 0
        bodyLabel.font = .body
        bodyLabel.adjustsFontForContentSizeCategory = true
        let stackView = UIStackView(arrangedSubviews: [bodyLabel])

        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }
    var listRows: [GDSListCellViewModel]
    let listTitle: GDSLocalisedString?
    let listFooter: GDSLocalisedString? = "Optional footer. Configure it on the view model in a similar way as the `body` property. The right bar button works the same way."
    let buttonViewModel: ButtonViewModel
    let secondaryButtonViewModel: ButtonViewModel?
    let rightBarButtonTitle: GDSLocalisedString? = "Right bar button"
    let backButtonIsHidden: Bool = false
    var selectedIndex: GDSLocalisedString = ""

    let screenView: () -> Void
    let dismissAction: () -> Void

    func didDismiss() {
        dismissAction()
    }

    func didAppear() {
        screenView()
    }

    init(secondaryButtonViewModel: ButtonViewModel? = nil,
         listTitle: GDSLocalisedString? = "Optional table title",
         screenView: (() -> Void)? = nil,
         dismissAction: (() -> Void)? = nil,
         buttonAction: (() -> Void)? = nil) {
        self.screenView = screenView ?? {}
        self.dismissAction = dismissAction ?? {}

        buttonViewModel = MockButtonViewModel(title: "Action button",
                                              icon: nil,
                                              shouldLoadOnTap: false,
                                              action: dismissAction ?? {})
        self.secondaryButtonViewModel = secondaryButtonViewModel
        self.listTitle = listTitle

        listRows = [MockListCellViewModel(title: "Table view list item 1",
                                          accessibilityLabel: "Table view list item 1",
                                          action: buttonAction ?? {}),
                    MockListCellViewModel(title: "Table view list item two",
                                          accessibilityLabel: "Table view list item two",
                                          action: buttonAction ?? {})]
    }
}
