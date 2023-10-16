import UIKit

public protocol LinkTheAppViewModel {
    var imageName: String { get }
    var title: GDSLocalisedString { get }
    var body: GDSLocalisedString { get }
    var contentViews: [UIView] { get }
}
