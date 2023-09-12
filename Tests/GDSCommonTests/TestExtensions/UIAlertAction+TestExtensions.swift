import UIKit

extension UIAlertAction {
    typealias AlertHandler = @convention(block) (UIAlertAction) -> Void

    // MARK: - Helper: Use Private APIs (naughty!) to trigger gesture recogniser
    // Do not use this in the main app bundle as it will result in rejection from the App Store!
    public func runHandler() {
        guard let handler = value(forKey: "handler") else { return }
        unsafeBitCast(handler as AnyObject, to: AlertHandler.self)(self)
    }
}
