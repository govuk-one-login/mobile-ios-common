import UIKit

final class ScanOverlayView: UIView {
    var orientationProvider: OrientationProvider = UIDevice.current

    private var isLandscape: Bool {
        orientationProvider.orientation.isLandscape
    }
    
    let overlayLayer = CAShapeLayer()

    var reticleSize: CGSize {
        let base = isLandscape ? bounds.height : bounds.width
        let size = base * 0.7
        return CGSize(width: size, height: size)
    }

    var viewfinderRect: CGRect {
        let landscapeAdjustment = UIDevice.current.orientation.isLandscape ? 30.0 : 0
        
        return CGRect(x: (bounds.width - reticleSize.width) / 2,
               y: ((bounds.height - reticleSize.height) / 2) + landscapeAdjustment,
               width: reticleSize.width,
               height: reticleSize.height)
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        overlayLayer.fillRule = .evenOdd
        overlayLayer.opacity = 0.5
        layer.addSublayer(overlayLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        overlayLayer.frame = frame
        overlayLayer.fillColor = UIColor.scannerBackground.cgColor
        overlayLayer.opacity = 0.7  
        let path = UIBezierPath()
        let overlayPath = UIBezierPath(rect: bounds)
        let windowPath = UIBezierPath(roundedRect: viewfinderRect,
                                      byRoundingCorners: .allCorners,
                                      cornerRadii: .init(width: 60, height: 60))
        
        path.append(overlayPath)
        path.append(windowPath)
        
        overlayLayer.path = path.cgPath
    }
}
