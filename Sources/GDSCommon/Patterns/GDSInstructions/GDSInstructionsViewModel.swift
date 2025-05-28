import UIKit

/// View model for the ``GDSInstructionsViewController``
/// - `title` type is ``GDSLocalisedString``
/// - `body` type is `NSAttributedString`
/// - `rightBarButtonTitle` type is ``GDSLocalisedString``?
/// - `childView type is `UIView`
/// - `primaryButtonViewModel` type is ``ButtonViewModel``
/// - `secondaryButtonViewModel` type is ``ButtonViewModel``?
///
/// `childView` is added at the bottom of the `stackView` that contains the `title` and
/// `body`. Because it is of type `UIView` the kind of view that can be added here is very flexible.
@MainActor
public protocol GDSInstructionsViewModel {
    var title: GDSLocalisedString { get }
    var body: String { get }
    var childView: UIView { get }
    var buttonViewModel: ButtonViewModel { get }
    var secondaryButtonViewModel: ButtonViewModel? { get }
}

/// View model for ``GDSInstructionsViewController``
/// If conforming to this view model, the primary button remains disabled when returning to the screen
///  otherwise, the primary button is enabled and can be tapped again
@MainActor
public protocol GDSInstructionsViewModelDisableButton {
    var shouldDisableOnTap: Bool { get }
}
