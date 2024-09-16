import Foundation
import UIKit

@MainActor
public protocol ContentTileViewModel {
    var image: UIImage? { get }
    var caption: GDSLocalisedString? { get }
    var title: GDSLocalisedString { get }
    var body: GDSLocalisedString? { get }
    var actionText: ButtonViewModel? { get }
    var actionButton: ButtonViewModel? { get }
    var dismissButton: ButtonViewModel? { get }
}
