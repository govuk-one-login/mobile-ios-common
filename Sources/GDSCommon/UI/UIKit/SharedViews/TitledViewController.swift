import UIKit

protocol TitledViewController: VoiceOverFocus {
    var titleLabel: UILabel! { get }
}

protocol VoiceOverFocus {
    var initialVoiceOverView: UIView? { get }
}

extension TitledViewController {
    var initialVoiceOverView: UIView? {
        titleLabel
    }
}
