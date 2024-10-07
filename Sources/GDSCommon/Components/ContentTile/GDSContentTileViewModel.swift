import Foundation
import UIKit

public typealias ExpandedContentTileViewModel = GDSContentTileViewModel &
                                                GDSContentTileViewModelWithImage &
                                                GDSContentTileViewModelWithDismissButton &
                                                GDSContentTileViewModelWithCaption &
                                                GDSContentTileViewModelWithBody &
                                                GDSContentTileViewModelWithSecondaryButton &
                                                GDSContentTileViewModelWithPrimaryButton

@MainActor
public protocol GDSContentTileViewModel {
    var title: GDSLocalisedString { get }
    var showSeparatorLine: Bool { get }
    var backgroundColour: UIColor? { get }
}

@MainActor
public protocol GDSContentTileViewModelWithImage {
    var image: UIImage { get }
}

@MainActor
public protocol GDSContentTileViewModelWithDismissButton {
    var closeButtonAction: () -> Void { get }
}

@MainActor
public protocol GDSContentTileViewModelWithCaption {
    var caption: GDSLocalisedString { get }
}

@MainActor
public protocol GDSContentTileViewModelWithBody {
    var body: GDSLocalisedString { get }
}

@MainActor
public protocol GDSContentTileViewModelWithSecondaryButton {
    var secondaryButtonViewModel: ButtonViewModel { get }
}

@MainActor
public protocol GDSContentTileViewModelWithPrimaryButton {
    var primaryButtonViewModel: ButtonViewModel { get }
}
