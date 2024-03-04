/// View model for the views with a primary button
/// - `primaryButtonViewModel` type is ``ButtonViewModel``
public protocol PageWithPrimaryButtonViewModel {
    var primaryButtonViewModel: ButtonViewModel { get }
}

/// View model for the views with a secondary button
/// - `secondaryButtonViewModel` type is ``ButtonViewModel``
public protocol PageWithSecondaryButtonViewModel {
    var secondaryButtonViewModel: ButtonViewModel { get }
}
