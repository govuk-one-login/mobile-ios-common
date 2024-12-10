import GDSCommon
import UIKit

// Conforming to the original deprecated protocol
struct MockGDSInformationViewModel: GDSInformationViewModel,
                                    BaseViewModel {
    let image: String = "lock"
    let imageWeight: UIFont.Weight? = nil
    let imageColour: UIColor? = nil
    let imageHeightConstraint: CGFloat? = nil
    let title: GDSLocalisedString = "This is an Information View title"
    let body: GDSLocalisedString? = "This is an (optional) Information View body."
    let footnote: GDSLocalisedString? = "This is an (optional) Information View footnote where additional information for the buttons can be detailed."
    let primaryButtonViewModel: ButtonViewModel = MockButtonViewModel.primary
    let secondaryButtonViewModel: ButtonViewModel? = MockButtonViewModel.secondary
    let rightBarButtonTitle: GDSLocalisedString? = nil
    let backButtonIsHidden: Bool = false
    
    func didAppear() {}
    
    func didDismiss() {}
}

// Conforming to deprecated V2 protocols
struct MockGDSInformationViewModelV2: GDSInformationViewModelV2,
                                      GDSInformationViewModelWithFootnote,
                                      GDSInformationViewModelPrimaryButton,
                                      GDSInformationViewModelWithSecondaryButton,
                                      GDSInformationViewModelWithChildView,
                                      BaseViewModel {
    let title: GDSLocalisedString = "This is an Information View title"
    let body: GDSLocalisedString? = "This is an (optional) Information View body."
    let image: String = "lock"
    let imageHeightConstraint: CGFloat? = nil
    let imageWeight: UIFont.Weight? = nil
    let imageColour: UIColor? = nil
    let footnote: GDSLocalisedString = "This is an (optional) Information View footnote where additional information for the buttons can be detailed."
    let primaryButtonViewModel: ButtonViewModel = MockButtonViewModel.primary
    let secondaryButtonViewModel: ButtonViewModel = MockButtonViewModel.secondary
    let rightBarButtonTitle: GDSLocalisedString? = nil
    let backButtonIsHidden: Bool = false
    
    var childView: UIView {
        createChildView()
    }
     
    func didAppear() { }
    
    func didDismiss() { }
    
    private func createChildView() -> UIView {
        let body = UILabel()
        body.text = GDSLocalisedString(stringLiteral: "This is a child view which can be populated with text or components").value
        body.adjustsFontForContentSizeCategory = true
        body.font = .body
        body.numberOfLines = 0
        body.textAlignment = .center
        let stackView = UIStackView(arrangedSubviews: [body])
        stackView.axis = .vertical
        stackView.alignment = .top
        stackView.alignment = .fill
        stackView.spacing = 16
        return stackView
    }
}

// Conforming to new protocol to that replaces the deprecated protocols
struct MockGDSCentreAlignedViewModel: GDSInformationViewModelWithTitleAndBody,
                                      GDSInformationViewModelWithImage,
                                      GDSInformationViewModelWithDynamicFootnote,
                                      GDSInformationViewModelPrimaryButton,
                                      GDSInformationViewModelWithSecondaryButton,
                                      GDSInformationViewModelWithChildView,
                                      BaseViewModel {
    let image: String = "lock"
    let imageWeight: UIFont.Weight? = nil
    let imageColour: UIColor? = nil
    let imageHeightConstraint: CGFloat? = 77
    let title: GDSLocalisedString = "This is an Information View title"
    let body: GDSLocalisedString? = "This is an (optional) Information View body."
    let footnote: GDSLocalisedString = "This is an (optional) Information View footnote where additional information for the buttons can be detailed."
    let primaryButtonViewModel: ButtonViewModel = MockButtonViewModel.primary
    let secondaryButtonViewModel: ButtonViewModel = MockButtonViewModel.secondary
    let rightBarButtonTitle: GDSLocalisedString? = nil
    let backButtonIsHidden: Bool = false

    func didAppear() {}

    func didDismiss() {}

    var childView: UIView {
        createChildView()
    }

    private func createChildView() -> UIView {
        let bulletView = BulletView(viewModel: MockBulletViewModel(title: "Optional child view - populated with a BulletView", titleFont: .body))
        let stackView = UIStackView(arrangedSubviews: [bulletView])
        stackView.axis = .vertical
        stackView.alignment = .top
        stackView.alignment = .fill
        stackView.spacing = 16
        return stackView
    }
}
