import GDSCommon
import UIKit

struct MockGDSInformationViewModel: GDSInformationViewModel, BaseViewModel {
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

struct MockGDSInformationViewModelWithChildView: GDSInformationViewModel, GDSInformationViewModelWithChildView, BaseViewModel {
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

    var childView: UIView? {
        createChildView()
    }

    private func createChildView() -> UIView {
        let bulletView = BulletView(viewModel: MockBulletViewModel(title: "This means", titleFont: .body))
        let body = UILabel()
        body.text = GDSLocalisedString(stringLiteral: "More (optional) text can follow, too").value
        body.adjustsFontForContentSizeCategory = true
        body.font = .body
        body.numberOfLines = 0
        let stackView = UIStackView(arrangedSubviews: [bulletView, body])
        stackView.axis = .vertical
        stackView.alignment = .top
        stackView.spacing = 12
        return stackView
    }
}
