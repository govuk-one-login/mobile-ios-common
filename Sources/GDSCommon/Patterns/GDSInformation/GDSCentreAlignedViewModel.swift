import UIKit

@MainActor
public protocol GDSInformationViewModelWithTitleAndBody {
    var title: GDSLocalisedString { get }
    var body: GDSLocalisedString? { get }
}

@MainActor
public protocol GDSInformationViewModelWithImage {
    var image: String { get }
    var imageHeightConstraint: CGFloat? { get } // should not have default
    var imageWeight: UIFont.Weight? { get }
    var imageColour: UIColor? { get }
}

@MainActor
public protocol GDSInformationViewModelWithDynamicFootnote {
    var footnote: GDSLocalisedString { get }
}
