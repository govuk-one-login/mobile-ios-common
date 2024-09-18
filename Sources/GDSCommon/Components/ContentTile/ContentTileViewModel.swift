import Foundation
import UIKit

@MainActor
public protocol ContentTileViewModel {
    var image: UIImage? { get }
    var caption: GDSLocalisedString? { get }
    var title: GDSLocalisedString { get }
    var body: GDSLocalisedString? { get }
    var secondaryButtonViewModel: ButtonViewModel? { get }
    var primaryButtonViewModel: ButtonViewModel? { get }
    var dismissButton: ButtonViewModel? { get }
}
