import UIKit

public final class RoundedButton: SecondaryButton {
    var initialBackgroundColor: UIColor?
    
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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        gdsInit()
    }

    @available(iOS 14, *)
    required public init(action: UIAction) {
        super.init()
        gdsInit()
        self.addAction(action, for: .touchUpInside)
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

    override func handleFocus(isFocused: Bool) {
        if isFocused {
            initialBackgroundColor = backgroundColor
            backgroundColor = .gdsYellow
            redrawTitle(with: .black)
        } else {
            backgroundColor = initialBackgroundColor
            redrawTitle(with: .white)
        }
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
