import UIKit

@IBDesignable
open class NibView: UIView {
    
    public var forcedNibName: String?
    public var view: UIView?
    
    public init(frame: CGRect = .zero, forcedNibName: String? = nil, bundle: Bundle? = nil) {
        self.forcedNibName = forcedNibName
        super.init(frame: frame)
        setup(bundle: bundle)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    public func setup(bundle: Bundle? = nil) {
        if let forcedNibName = forcedNibName {
            setupNib(forcedNibName, bundle: bundle)
        } else if let nibName = classForCoder.description().components(separatedBy: ".").last {
            setupNib(String(nibName), bundle: bundle)
        }
    }
    
    func setupNib(_ nibName: String, bundle: Bundle?) {
        if let view = loadViewFromNib(nibName, bundle: bundle) {
            self.view = view
            self.view?.frame = bounds
            self.view?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addSubview(view)
        }
    }
    
    func loadViewFromNib(_ nibName: String, bundle: Bundle?) -> UIView? {
        let bundle = bundle ?? Bundle(for: Self.self)
        if bundle.path(forResource: nibName, ofType: "nib") != nil {
            let nib = UINib(nibName: nibName, bundle: bundle)
            if let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView {
                return view
            }
        }
        return nil
    }
}
