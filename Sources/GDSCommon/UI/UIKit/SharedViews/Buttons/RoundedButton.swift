import UIKit

public final class RoundedButton: SecondaryButton {
    public var isLoading: Bool = false {
        didSet {
            isLoading ? startLoading() : stopLoading()
        }
    }
    
    public var isTitleHidden: Bool = false {
        didSet {
           titleLabel?.isHidden = isTitleHidden
        }
    }
    
    public override var isEnabled: Bool {
        didSet {
            alpha = isEnabled ? 1 : 0.5
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel?.isHidden = isTitleHidden
    }
    
    public override init() {
        super.init()
        gdsInit()
    }
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .medium
        activityIndicator.color = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    private func startLoading() {
        self.isTitleHidden = true
        self.isEnabled = false
        self.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        activityIndicator.startAnimating()
    }

    private func stopLoading() {
        self.isTitleHidden = false
        self.isEnabled = true
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }

    public override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if let nextItem = context.nextFocusedItem, nextItem.isEqual(self) {
            backgroundColor = .gdsYellow
            setTitleColor(.black, for: .normal)
        } else {
            backgroundColor = .gdsGreen
            setTitleColor(.white, for: .normal)
        }
    }
    
    public override func accessibilityElementDidBecomeFocused() {
        backgroundColor = .gdsYellow
        setTitleColor(.black, for: .normal)
    }

    public override func accessibilityElementDidLoseFocus() {
        backgroundColor = .gdsGreen
        setTitleColor(.white, for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        gdsInit()
    }
    
    public override func buttonBackground() {
        backgroundColor = .gdsGreen
        color = .white
        setTitleColor(.white, for: .normal)
        contentEdgeInsets = .init(top: 13, left: 8, bottom: 13, right: 8)
        fontWeight = .semibold
        titleLabel?.font = UIFont(style: .body, weight: fontWeight)
        layer.cornerRadius = 15
        layer.cornerCurve = .continuous
    }
    
    private func gdsInit() {
        buttonBackground()
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(greaterThanOrEqualToConstant: 44)
        ])
    }
}
