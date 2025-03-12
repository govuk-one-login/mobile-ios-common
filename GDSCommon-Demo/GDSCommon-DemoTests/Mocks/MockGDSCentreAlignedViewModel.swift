import GDSCommon
import UIKit

struct MockGDSCentreAlignedViewModel: GDSCentreAlignedViewModel,
                                      GDSCentreAlignedViewModelWithImage,
                                      GDSCentreAlignedViewModelWithFootnote,
                                      GDSCentreAlignedViewModelWithPrimaryButton,
                                      GDSCentreAlignedViewModelWithSecondaryButton,
                                      GDSCentreAlignedViewModelWithChildView,
                                      GDSCentreAlignedViewModelWithVoiceoverHint,
                                      BaseViewModel {
    let image: String = "lock"
    let imageWeight: UIFont.Weight? = .semibold
    let imageColour: UIColor? = .gdsPrimary
    let imageHeightConstraint: CGFloat? = 55
    let title: GDSLocalisedString = "Centre aligned screen title"
    let body: GDSLocalisedString? = "Centre aligned screen body"
    var childView: UIView {
        createChildView()
    }
    let footnote: GDSLocalisedString = "Centre aligned screen footnote"
    let primaryButtonViewModel: ButtonViewModel
    let secondaryButtonViewModel: ButtonViewModel
    
    let rightBarButtonTitle: GDSLocalisedString? = "right bar button"
    let backButtonIsHidden: Bool = false
    let appearAction: () -> Void
    let dismissAction: () -> Void
    let voiceoverHint: String = "Centre aligned screen accessibility hint"
    
    init(primaryButtonViewModel: ButtonViewModel,
         secondaryButtonViewModel: ButtonViewModel,
         appearAction: @escaping () -> Void,
         dismissAction: @escaping () -> Void) {
        self.primaryButtonViewModel = primaryButtonViewModel
        self.secondaryButtonViewModel = secondaryButtonViewModel
        self.appearAction = appearAction
        self.dismissAction = dismissAction
    }
    
    func didAppear() {
        appearAction()
    }
    
    func didDismiss() {
        dismissAction()
    }

    private func createChildView() -> UIView {
        let bulletView = createMockBulletView()
        let body = UILabel()
        body.text = GDSLocalisedString(stringLiteral: "More text").value
        body.accessibilityIdentifier = "body-text"
        body.font = .body
        body.adjustsFontForContentSizeCategory = true
        body.numberOfLines = 0
        let stackView = UIStackView(arrangedSubviews: [bulletView, body])
        stackView.axis = .vertical
        stackView.alignment = .top
        stackView.spacing = 12
        return stackView
    }

    private func createMockBulletView() -> BulletView {
        let bulletView = BulletView(title: "bullet title",
                                    text: ["bullet 1",
                                           "bullet 2",
                                           "bullet 3"],
                                    titleFont: .body)
        return bulletView
    }
}

struct MockGDSCentreAlignedViewModelNoImage: GDSCentreAlignedViewModel,
                                             GDSCentreAlignedViewModelWithFootnote,
                                             GDSCentreAlignedViewModelWithPrimaryButton,
                                             GDSCentreAlignedViewModelWithSecondaryButton,
                                             BaseViewModel {
    let title: GDSLocalisedString = "Centre aligned screen title"
    let body: GDSLocalisedString? = "Centre aligned screen body"
    let footnote: GDSLocalisedString = "Centre aligned screen footnote"
    let primaryButtonViewModel: ButtonViewModel
    let secondaryButtonViewModel: ButtonViewModel
    
    let rightBarButtonTitle: GDSLocalisedString? = "right bar button"
    let backButtonIsHidden: Bool = false
    let appearAction: () -> Void
    let dismissAction: () -> Void
    
    init(primaryButtonViewModel: ButtonViewModel,
         secondaryButtonViewModel: ButtonViewModel,
         appearAction: @escaping () -> Void,
         dismissAction: @escaping () -> Void) {
        self.primaryButtonViewModel = primaryButtonViewModel
        self.secondaryButtonViewModel = secondaryButtonViewModel
        self.appearAction = appearAction
        self.dismissAction = dismissAction
    }
    
    func didAppear() {
        appearAction()
    }
    
    func didDismiss() {
        dismissAction()
    }
}

struct MockGDSInformationViewModelV2: GDSInformationViewModelV2,
                                      GDSInformationViewModelWithFootnote,
                                      GDSInformationViewModelWithOptionalPrimaryButton,
                                      GDSInformationViewModelWithSecondaryButton {
    let image: String = "lock"
    let imageWeight: UIFont.Weight? = .semibold
    let imageColour: UIColor? = .gdsPrimary
    let imageHeightConstraint: CGFloat? = 55
    let title: GDSLocalisedString = "V2 Information screen title"
    let body: GDSLocalisedString? = "V2 Information screen body"
    let footnote: GDSLocalisedString = "V2 Information screen footnote"
    let primaryButtonViewModel: ButtonViewModel?
    let secondaryButtonViewModel: ButtonViewModel
    
    init(primaryButtonViewModel: ButtonViewModel?,
         secondaryButtonViewModel: ButtonViewModel) {
        self.primaryButtonViewModel = primaryButtonViewModel
        self.secondaryButtonViewModel = secondaryButtonViewModel
    }
}

struct MockGDSInformationViewModel: GDSInformationViewModel {
    let title: GDSLocalisedString = "Information screen title"
    let body: GDSLocalisedString? = "Information screen body"
    let image: String = "lock"
    let imageWeight: UIFont.Weight? = .semibold
    let imageColour: UIColor? = .gdsPrimary
    let imageHeightConstraint: CGFloat? = 55
    let footnote: GDSLocalisedString? = "Information screen footnote"
    let primaryButtonViewModel: ButtonViewModel
    let secondaryButtonViewModel: ButtonViewModel?

    init(primaryButtonViewModel: ButtonViewModel,
         secondaryButtonViewModel: ButtonViewModel?) {
        self.primaryButtonViewModel = primaryButtonViewModel
        self.secondaryButtonViewModel = secondaryButtonViewModel
    }
}
