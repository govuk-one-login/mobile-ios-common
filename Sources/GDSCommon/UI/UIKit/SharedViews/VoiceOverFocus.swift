import UIKit

public protocol VoiceOverFocus {
    var initialVoiceOverView: UIView { get }
}

protocol TitledViewController: VoiceOverFocus {
    var titleLabel: UILabel! { get }
}

extension TitledViewController {
    public var initialVoiceOverView: UIView {
        titleLabel
    }
}
