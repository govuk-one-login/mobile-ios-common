import UIKit

@MainActor
public protocol GDSCentreAlignedViewModel {
    var title: GDSLocalisedString { get }
    var body: GDSLocalisedString? { get }
}

@MainActor
public protocol GDSCentreAlignedViewModelWithImage {
    var image: String { get }
    var imageHeightConstraint: CGFloat { get }
    var imageWeight: UIFont.Weight? { get }
    var imageColour: UIColor? { get }
}

@MainActor
public protocol GDSCentreAlignedViewModelWithFootnote {
    var footnote: GDSLocalisedString { get }
}

@MainActor
public protocol GDSCentreAlignedViewModelWithPrimaryButton {
    var primaryButtonViewModel: ButtonViewModel { get }
}

@MainActor
public protocol GDSCentreAlignedViewModelWithSecondaryButton {
    var secondaryButtonViewModel: ButtonViewModel { get }
}

@MainActor
public protocol GDSCentreAlignedViewModelWithChildView {
    var childView: UIView { get }
}
