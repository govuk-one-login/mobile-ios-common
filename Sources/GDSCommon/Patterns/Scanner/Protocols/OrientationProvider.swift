import UIKit

protocol OrientationProvider {
    var orientation: UIDeviceOrientation { get }
}

extension UIDevice: OrientationProvider { }
