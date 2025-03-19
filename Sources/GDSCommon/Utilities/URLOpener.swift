import UIKit

@MainActor
public protocol URLOpener {
    func open(url: URL)
}

extension UIApplication: URLOpener {
    @MainActor
    public func open(url: URL) {
        open(url)
    }
}
