import UIKit

public protocol IconOptionsViewModel {
    var imageName: String { get }
    var title: GDSLocalisedString { get }
    var body: GDSLocalisedString { get }
    var contentViews: [UIView] { get }
}
