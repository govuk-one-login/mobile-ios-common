import UIKit

/// View model for the `IconScreenViewController`
/// - `image` type is `UIImage`
/// - `title` type is ``GDSLocalisedString``
/// - `body` type is ``GDSLocalisedString``
/// - `childViews` type is `[UIView]`
///
/// Additionally there is a protocol method `didAppear()` which should be used
/// for any code that needs to be performed when the screen appears.
/// For example, this might include tracking an analytics screen view, but it could be used
/// for other code such as making an API call.
public protocol IconScreenViewModel: BaseViewModel {
    var imageName: String { get }
    var title: GDSLocalisedString { get }
    var body: GDSLocalisedString { get }
    var childViews: [UIView] { get }
}
