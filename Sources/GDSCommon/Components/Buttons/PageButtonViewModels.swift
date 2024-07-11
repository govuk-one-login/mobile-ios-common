/// View model for the views with a primary button
/// - `primaryButtonViewModel` type is ``ButtonViewModel``
@MainActor
public protocol PageWithPrimaryButtonViewModel {
    var primaryButtonViewModel: ButtonViewModel { get }
}

/// View model for the views with a secondary button
/// - `secondaryButtonViewModel` type is ``ButtonViewModel``
@MainActor
public protocol PageWithSecondaryButtonViewModel {
    var secondaryButtonViewModel: ButtonViewModel { get }
}

/// View model for the views with a button that displays as text i.e privacy policy
///  - `textButtonViewModel` type is ``ButtonViewModel``
@MainActor
public protocol PageWithTextButtonViewModel {
    var textButtonViewModel: ButtonViewModel { get }
}
