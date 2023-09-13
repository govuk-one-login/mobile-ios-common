import UIKit

public protocol URLOpener {
    func open(url: URL)
}

extension UIApplication: URLOpener {
    public func open(url: URL) {
        open(url)
    }
}
