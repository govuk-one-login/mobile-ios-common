import UIKit

public class SecondaryButton: UIButton {
    @IBInspectable public var icon: String? {
        didSet {
            redrawTitle(with: color)
        }
    }
    
    public var font: UIFont?
    public var fontWeight: UIFont.Weight = .regular
    public var color: UIColor = .accent
    public var symbolPosition: SymbolPosition = .afterTitle
    
    public override var intrinsicContentSize: CGSize {
        let titlesize = titleLabel?.intrinsicContentSize ?? .zero
        
        return CGSize(width: titlesize.width + contentEdgeInsets.horizontal,
                      height: titlesize.height + contentEdgeInsets.vertical)
    }
    
    public init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    @available(iOS 14, *)
    required public init(action: UIAction) {
        super.init(frame: .zero)
        commonInit()
        self.addAction(action, for: .touchUpInside)
    }
    
    private func commonInit() {
        let font = font ?? UIFont(style: .body, weight: fontWeight)
        titleLabel?.numberOfLines = 0
        titleLabel?.lineBreakMode = .byWordWrapping
        titleLabel?.adjustsFontForContentSizeCategory = true
        titleLabel?.font = font
        titleLabel?.tintColor = color
        
        if #available(iOS 14.0, *) {
            buttonBackground()
        }
        
        NotificationCenter.default.addObserver(forName: UIContentSizeCategory.didChangeNotification, object: nil, queue: nil) { _ in
            self.redrawTitle(with: self.color)
        }
        
        if #available(iOS 14.0, *) {
            NotificationCenter.default.addObserver(forName: Notification.Name( "buttonShapesEnabled"),
                                                   object: nil,
                                                   queue: nil) { _ in
                self.buttonBackground()
            }
        }
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(greaterThanOrEqualToConstant: 24),
            self.widthAnchor.constraint(greaterThanOrEqualToConstant: 24)
        ])
    }
    
    deinit {
        NotificationCenter.default.removeObserver(UIContentSizeCategory.didChangeNotification)
        NotificationCenter.default.removeObserver(Notification.Name( "buttonShapesEnabled"))
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        guard let width = titleLabel?.frame.width else { return }
        titleLabel?.preferredMaxLayoutWidth = width
    }
    
    public func setTitle(_ title: GDSLocalisedString, for state: UIControl.State) {
        setTitle(title.value, for: state)
    }
    
    public override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: state)
        super.accessibilityLabel = title
        redrawTitle(with: color)
    }
    
    public override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        handleFocus(isFocused: isFocused)
    }
    
    func handleFocus(isFocused: Bool) {
        if isFocused {
            backgroundColor = .gdsYellow
            layer.cornerRadius = 4
            redrawTitle(with: .black)
        } else {
            redrawTitle(with: color)
            if #available(iOS 14.0, *) {
                buttonBackground()
            }
        }
    }
}

extension SecondaryButton {
    internal func redrawTitle(with colour: UIColor) {
        // only need to redraw if there is an icon set
        // otherwise text will dynamically resize automatically
        guard let icon = icon else {
            setTitleColor(colour, for: .normal)
            return
        }

        let font = font ?? UIFont(style: .body, weight: fontWeight)
        let configuration = UIImage.SymbolConfiguration(font: font)
        let title = self.title(for: .normal) ?? ""
        let textString = NSAttributedString(string: title,
                                            attributes: [.font: font])
            .addingSymbol(named: icon, configuration: configuration, tintColor: colour, symbolPosition: symbolPosition)
        UIView.performWithoutAnimation {
            self.setAttributedTitle(textString, for: .normal)
            self.setTitleColor(colour, for: .normal)
            self.layoutIfNeeded()
        }
    }
    
    @available(iOS 14.0, *)
    @objc public func buttonBackground() {
        let font = font ?? UIFont(style: .body, weight: fontWeight)
        if UIAccessibility.buttonShapesEnabled {
            backgroundColor = .secondarySystemBackground
            contentEdgeInsets = .init(top: 13, left: 8, bottom: 13, right: 8)
            titleLabel?.font = font
            layer.cornerRadius = 10
            layer.cornerCurve = .continuous
        } else {
            backgroundColor = .none
        }
    }
}
