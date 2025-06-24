import UIKit

/// Conform view controllers that inhereit from ``BaseViewController`` to this protocol to benefit
/// from setting the initial VoiceOver focus when the screen appears.
/// The focus is directed by the `viewIsAppearing` lifecycle method.
@MainActor
public protocol VoiceOverFocus {
    var initialVoiceOverView: UIView { get }
}

/// For screen view controllers within `GDSCommon` that have a ``titleLabel`` property and inherits
/// from ``BaseViewController``, conform the view controller to ``TitledViewController`` to
/// automaticaly direct VoiceOver to the ``titleLabel`` when the screen appears
@MainActor
public protocol TitledViewController: VoiceOverFocus {
    var titleLabel: UILabel! { get }
}

extension TitledViewController {
    public var initialVoiceOverView: UIView {
        titleLabel
    }
}

@MainActor
public protocol TitledViewControllerV2: VoiceOverFocus {
    var titleLabel: UILabel { get }
}

extension TitledViewControllerV2 {
    public var initialVoiceOverView: UIView {
        titleLabel
    }
}
