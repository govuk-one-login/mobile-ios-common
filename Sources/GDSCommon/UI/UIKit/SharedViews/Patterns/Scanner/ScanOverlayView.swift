import UIKit

final class ScanOverlayView: UIView {
    let overlayLayer = CAShapeLayer()
    
    var reticleInset: CGFloat {
        0.1 * bounds.width
    }
    
    private var reticleWidth: CGFloat {
        min(bounds.height, bounds.width) - (reticleInset * 3)
    }
    
    private var reticleHeight: CGFloat {
        min(bounds.height, bounds.width) - (reticleInset * 3)
    }
    
    var viewfinderRect: CGRect {
        CGRect(x: (bounds.width - reticleWidth) / 2,
               y: (bounds.height - reticleHeight) / 2,
               width: reticleWidth,
               height: reticleHeight)
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        overlayLayer.fillColor = UIColor.systemBackground.cgColor
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
