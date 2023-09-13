import UIKit

public final class CheckmarkDialogAccessoryView: UIView {

    private(set) var checkmarkLayer: CheckmarkLayer?
    private(set) var loadingViewLayer: CALayer?
    private(set) var loadingView: UIActivityIndicatorView?
    
    private var isLoading: Bool
    
    public init(isLoading: Bool = false) {
        self.isLoading = isLoading
        
        super.init(frame: .zero)
    }
    
    @available(*, unavailable, renamed: "init(isLoading:)")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var checkmarkDiameter: CGFloat {
        bounds.height
    }
    
    private var checkmarkFrame: CGRect {
        CGRect(origin: checkmarkOrigin,
                      size: CGSize(width: checkmarkDiameter,
                                   height: checkmarkDiameter))
    }
        
    private var checkmarkOrigin: CGPoint {
        let x = (0 + (bounds.width / 2) - (checkmarkDiameter / 2))
        let y = (0 + (bounds.height / 2) - (checkmarkDiameter / 2))
        return CGPoint(x: x, y: y)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        if isLoading {
            makeLoadingLayer()
        } else {
            makeCheckmarkLayer()
        }
    }
    
    private func makeCheckmarkLayer() {
        checkmarkLayer?.removeFromSuperlayer()
        loadingViewLayer?.removeFromSuperlayer()
        let newCheckmarkLayer = CheckmarkLayer(frame: checkmarkFrame)
        self.checkmarkLayer = newCheckmarkLayer
        layer.addSublayer(newCheckmarkLayer)
    }
    
    private func makeLoadingLayer() {
        self.checkmarkLayer?.removeFromSuperlayer()
        self.loadingViewLayer?.removeFromSuperlayer()

        let newLoadingView: UIActivityIndicatorView = .init(frame: frame)
        newLoadingView.color = .white
        newLoadingView.style = .large
        self.loadingView = newLoadingView
        self.loadingViewLayer = newLoadingView.layer
        layer.addSublayer(loadingViewLayer!)
    }
}

extension CheckmarkDialogAccessoryView: DialogAccessoryView {
    public func updateLoadingState(isLoading: Bool) {
        self.isLoading = isLoading
        
        if isLoading {
            makeLoadingLayer()
        } else {
            makeCheckmarkLayer()
        }
    }
    
    public func playAnimation() {
        checkmarkLayer?.playAnimation()
    }
    
    public func playLoadingAnimation() {
        loadingView?.startAnimating()
    }
}
