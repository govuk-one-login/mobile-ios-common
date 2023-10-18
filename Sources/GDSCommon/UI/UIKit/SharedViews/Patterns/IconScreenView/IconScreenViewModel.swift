import UIKit

public protocol IconScreenViewModel {
    var imageName: String { get }
    var title: GDSLocalisedString { get }
    var body: GDSLocalisedString { get }
    var childViews: [UIView] { get }
    
    func didAppear()
}
