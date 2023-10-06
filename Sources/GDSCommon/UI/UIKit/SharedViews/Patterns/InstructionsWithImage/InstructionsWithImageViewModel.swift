import UIKit

/// View model for the `InstructionsWithImageViewController`
/// - `title` type is ``GDSLocalisedString``
/// - `body` type is `NSAttributedString`
/// - `image` type is `UIImage`
/// - `warningButtonViewModel` type is ``ButtonViewModel``?
/// - `primaryButtonViewModel` type is ``ButtonViewModel``
///
/// Additionally there is a protocol method `didAppear()` which should be used
/// for any code that needs to be performed when the screen appears.
/// For example, this might include tracking an analytics screen view, but it could be used
/// for other code such as making an API call.
public protocol InstructionsWithImageViewModel {
    var title: GDSLocalisedString { get }
    var body: NSAttributedString { get }
    var image: UIImage { get }
    var warningButtonViewModel: ButtonViewModel? { get }
    var primaryButtonViewModel: ButtonViewModel { get }
    
    func didAppear()
}
