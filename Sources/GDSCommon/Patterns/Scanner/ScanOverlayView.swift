import UIKit

final class ScanOverlayView: UIView {
    private var isLandscape: Bool {
        UIDevice.current.orientation.isLandscape
    }
    
    let overlayLayer = CAShapeLayer()
    
    var reticleInset: CGFloat {
        let base = isLandscape ? bounds.height : bounds.width
//        print(isLandscape ? "base (height): \(base)" : "base (width): \(base)")
        return 0.1 * base
    }
    
    private var reticleWidth: CGFloat {
        min(bounds.height, bounds.width) - (reticleInset * 3)
    }
    
    private var reticleHeight: CGFloat {
        min(bounds.height, bounds.width) - (reticleInset * 3)
    }
    
    var viewfinderRect: CGRect {
        print("width: \(reticleWidth), height: \(reticleHeight)")
        return CGRect(x: (bounds.width - reticleWidth) / 2,
               y: (bounds.height - reticleHeight) / 2,
               width: reticleWidth,
               height: reticleHeight)
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
