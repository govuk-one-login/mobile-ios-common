import UIKit

public protocol LinkTheAppViewModel {
    var imageName: String { get }
    var title: GDSLocalisedString { get }
    var subtitle: GDSLocalisedString { get }
}
