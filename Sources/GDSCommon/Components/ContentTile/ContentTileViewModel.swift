import Foundation
import UIKit

public typealias ContentTile = ContentTileViewModel &
ContentTileViewModelWithImage &
ContentTileViewModelWithDismissButton &
ContentTileViewModelWithCaption &
ContentTileViewModelWithBody &
ContentTileViewModelWithSecondaryButton &
ContentTileViewModelWithPrimaryButton

@MainActor
public protocol ContentTileViewModel {
    var title: GDSLocalisedString { get }
    var showSeparatorLine: Bool { get }
    var backgroundColour: UIColor? { get }
}

@MainActor
public protocol ContentTileViewModelWithImage {
    var image: UIImage { get }
}

@MainActor
public protocol ContentTileViewModelWithDismissButton {
    var closeButton: ButtonViewModel { get }
}

@MainActor
public protocol ContentTileViewModelWithCaption {
    var caption: GDSLocalisedString { get }
}

@MainActor
public protocol ContentTileViewModelWithBody {
    var body: GDSLocalisedString { get }
}

@MainActor
public protocol ContentTileViewModelWithSecondaryButton {
    var secondaryButtonViewModel: ButtonViewModel { get }
}

@MainActor
public protocol ContentTileViewModelWithPrimaryButton {
    var primaryButtonViewModel: ButtonViewModel { get }
}
