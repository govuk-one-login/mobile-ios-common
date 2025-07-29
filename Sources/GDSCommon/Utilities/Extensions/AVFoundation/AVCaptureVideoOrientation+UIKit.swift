import AVFoundation
import UIKit

extension AVCaptureVideoOrientation {
    /*:
     landscapeLeft is assigned to landscapeRight and vice versa is because rotating the device requires rotating the content in the opposite direction. See [here](https://developer.apple.com/documentation/uikit/uiinterfaceorientation/)
     */
    init?(deviceOrientation: UIDeviceOrientation) {
        switch deviceOrientation {
        case .portrait: self = .portrait
        case .portraitUpsideDown: self = .portraitUpsideDown
        case .landscapeLeft: self = .landscapeRight
        case .landscapeRight: self = .landscapeLeft
        default: return nil
        }
    }
    
    init?(interfaceOrientation: UIInterfaceOrientation) {
        switch interfaceOrientation {
        case .portrait: self = .portrait
        case .portraitUpsideDown: self = .portraitUpsideDown
        case .landscapeLeft: self = .landscapeLeft
        case .landscapeRight: self = .landscapeRight
        default: return nil
        }
    }
}
