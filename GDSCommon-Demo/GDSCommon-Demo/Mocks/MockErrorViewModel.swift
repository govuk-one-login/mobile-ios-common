import GDSCommon
import UIKit

private func mockChildView(
    _ alignment: UIStackView.Alignment = .leading
) -> UIView {
    let label = UILabel()
    label.font = UIFont(style: .body)
    label.text = "This is a child view"
    
    let button = SecondaryButton()
    button.setTitle(GDSLocalisedString("Text"), for: .normal)
    button.titleLabel?.textAlignment = .left
    button.titleLabel?.textColor = .gdsGreen
    button.symbolPosition = .afterTitle
    button.icon = "arrow.up.right"
    
    return UIStackView(
        views: [
            label,
            button
        ],
        alignment: alignment,
        distribution: .equalSpacing
    )
}

struct MockErrorViewModel: GDSErrorViewModelV2, GDSErrorViewModelWithImage, BaseViewModel {
    let image: String = "exclamationmark.circle"
    let title: GDSLocalisedString = "This is an Error View title"
    let body: GDSLocalisedString = "This is an Error View body This is an Error View body"
    let primaryButtonViewModel: ButtonViewModel = MockButtonViewModel.primary
    let secondaryButtonViewModel: ButtonViewModel? = MockButtonViewModel.secondary
    let rightBarButtonTitle: GDSLocalisedString? = nil
    let backButtonIsHidden: Bool = false
    
    func didAppear() {}
    func didDismiss() {}
}

struct MockErrorViewModelV3WithTwoButtons: GDSErrorViewModelV3, BaseViewModel {
    let errorDefaults = ErrorDefaults()
    let title: GDSLocalisedString = "This is an Error View title"
    let body: GDSLocalisedString? = "This is an Error View body that should span onto multiple lines"
    let rightBarButtonTitle: GDSLocalisedString? = nil
    let backButtonIsHidden: Bool = false
    
    var childView: UIView? { mockChildView() }
    var buttonViewModels: [any ButtonViewModel] = [
        MockButtonViewModel.primary,
        MockButtonViewModel.secondary
    ]
    
    func didAppear() {}
    func didDismiss() {}
}

struct MockErrorViewModelV3Warning: GDSErrorViewModelV3, BaseViewModel {
    let errorDefaults = ErrorDefaults(voiceOverPrefix: "Warning")
    let title: GDSLocalisedString = "This is an Warning Error View title"
    let body: GDSLocalisedString? = "This is an Warning Error View body that should span onto multiple lines"
    let rightBarButtonTitle: GDSLocalisedString? = nil
    let backButtonIsHidden: Bool = false
    
    var childView: UIView?
    var buttonViewModels: [any ButtonViewModel] = [
        MockButtonViewModel.primary,
        MockButtonViewModel.secondary
    ]
    
    func didAppear() {}
    func didDismiss() {}
}

struct MockErrorViewModelV3AppUpdate: GDSErrorViewModelV3, BaseViewModel {
    let errorDefaults = ErrorDefaults(image: "exclamationmark.arrow.trianglehead.counterclockwise.rotate.90")
    let title: GDSLocalisedString = "This is an App Update Error View title"
    let body: GDSLocalisedString? = "This is an App Update Error View body that should span onto multiple lines"
    let rightBarButtonTitle: GDSLocalisedString? = nil
    let backButtonIsHidden: Bool = false
    
    var childView: UIView? { mockChildView() }
    var buttonViewModels: [any ButtonViewModel] = [
        MockButtonViewModel.primary
    ]
    
    func didAppear() {}
    func didDismiss() {}
}

struct MockErrorViewModelV3Modal: GDSErrorViewModelV3, BaseViewModel {
    let errorDefaults = ErrorDefaults()
    let title: GDSLocalisedString = "This is an modal Error View title"
    let body: GDSLocalisedString? = "This is an modal Error View body that should span onto multiple lines"
    let rightBarButtonTitle: GDSLocalisedString? = "Cancel"
    let backButtonIsHidden: Bool = false
   
    var childView: UIView? { mockChildView() }
    var buttonViewModels: [any ButtonViewModel] = [
        MockButtonViewModel.primary,
        MockButtonViewModel.secondary
    ]
    
    func didAppear() {}
    func didDismiss() {}
}

struct MockErrorViewModelV3WithNoButtons: GDSErrorViewModelV3, BaseViewModel {
    let errorDefaults = ErrorDefaults()
    let title: GDSLocalisedString = "This is an Error View title"
    let body: GDSLocalisedString? = "This is an Error View body that should span onto multiple lines"
    let rightBarButtonTitle: GDSLocalisedString? = nil
    let backButtonIsHidden: Bool = false
        
    var childView: UIView? { mockChildView(.center) }
    var buttonViewModels: [any ButtonViewModel] = []
    
    func didAppear() {}
    func didDismiss() {}
}

struct MockErrorViewModelV3WithThreeButtons: GDSErrorViewModelV3, BaseViewModel {
    let errorDefaults = ErrorDefaults()
    let title: GDSLocalisedString = "This is an Error View title"
    let body: GDSLocalisedString? = "This is an Error View body that should span onto multiple lines"
    
    let rightBarButtonTitle: GDSLocalisedString? = nil
    let backButtonIsHidden: Bool = false
    
    var childView: UIView? { mockChildView() }
    
    var buttonViewModels: [any ButtonViewModel] = [
        MockButtonViewModel.primary,
        MockButtonViewModel.secondary,
        MockButtonViewModel.tertiary
    ]
    
    func didAppear() {}
    func didDismiss() {}
}

struct MockErrorViewModelNoIcon: GDSErrorViewModelV2, BaseViewModel {
    let title: GDSLocalisedString = "This is an Error View title"
    let body: GDSLocalisedString = "This is an Error View body This is an Error View body"
    let primaryButtonViewModel: ButtonViewModel = MockButtonViewModel.primary
    let secondaryButtonViewModel: ButtonViewModel? = MockButtonViewModel.secondary
    let rightBarButtonTitle: GDSLocalisedString? = nil
    let backButtonIsHidden: Bool = false
    
    func didAppear() {}
    func didDismiss() {}
}

struct MockErrorViewModelWithTertiary: GDSErrorViewModelV2, GDSErrorViewModelWithImage, GDSScreenWithTertiaryButtonViewModel, BaseViewModel {
    let image: String = "exclamationmark.circle"
    let title: GDSLocalisedString = "This is an Error View title"
    let body: GDSLocalisedString = "This is an Error View body This is an Error View body"
    let primaryButtonViewModel: ButtonViewModel = MockButtonViewModel.primary
    let secondaryButtonViewModel: ButtonViewModel? = MockButtonViewModel.secondary
    let tertiaryButtonViewModel: ButtonViewModel = MockButtonViewModel.secondary
    let rightBarButtonTitle: GDSLocalisedString? = nil
    let backButtonIsHidden: Bool = false
    
    func didAppear() {}
    func didDismiss() {}
}
