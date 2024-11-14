import UIKit

public class SecondaryButton: UIButton {
    @IBInspectable public var icon: String? {
        didSet {
            redrawTitle()
        }
    }
    
    public var fontWeight: UIFont.Weight = .regular
    public var color: UIColor = .accent
    public var symbolPosition: SymbolPosition = .afterTitle

    var minimumSize: CGFloat = 24

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
        titleLabel?.numberOfLines = 0
        titleLabel?.lineBreakMode = .byWordWrapping
        titleLabel?.adjustsFontForContentSizeCategory = true
        titleLabel?.font = UIFont(style: .body, weight: fontWeight)
        titleLabel?.tintColor = color
        
        if #available(iOS 14.0, *) {
            buttonBackground()
        }
        
        NotificationCenter.default.addObserver(forName: UIContentSizeCategory.didChangeNotification, object: nil, queue: nil) { _ in
            self.redrawTitle()
        }
        
        if #available(iOS 14.0, *) {
            NotificationCenter.default.addObserver(forName: Notification.Name( "buttonShapesEnabled"),
                                                   object: nil,
                                                   queue: nil) { _ in
                self.buttonBackground()
            }
        }

        layoutSubviews()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(UIContentSizeCategory.didChangeNotification)
        NotificationCenter.default.removeObserver(Notification.Name( "buttonShapesEnabled"))
    }
    
    public override func layoutSubviews() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(greaterThanOrEqualToConstant: minimumSize),
            self.widthAnchor.constraint(greaterThanOrEqualToConstant: minimumSize)
        ])

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
        redrawTitle()
    }
}

extension SecondaryButton {
    private func redrawTitle() {
        // only need to redraw if there is an icon set
        // otherwise text will dynamically resize automatically
        guard let icon = icon else { return }
        
        let configuration = UIImage.SymbolConfiguration(font: .init(style: .body, weight: fontWeight))
        let title = self.title(for: .normal) ?? ""
        let textString = NSAttributedString(string: title,
                                            attributes: [.font: UIFont(style: .body, weight: fontWeight)])
            .addingSymbol(named: icon, configuration: configuration, tintColor: color, symbolPosition: symbolPosition)
        self.setAttributedTitle(textString, for: .normal)
    }
    
    @available(iOS 14.0, *)
    @objc public func buttonBackground() {
        if UIAccessibility.buttonShapesEnabled {
            backgroundColor = .secondarySystemBackground
            contentEdgeInsets = .init(top: 13, left: 8, bottom: 13, right: 8)
            titleLabel?.font = UIFont(style: .body, weight: fontWeight)
            layer.cornerRadius = 10
            layer.cornerCurve = .continuous
        } else {
            backgroundColor = .none
        }
    }
}
