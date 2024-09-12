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
        let bulletView = BulletView(viewModel: MockBulletViewModel(title: nil))
        let body = UILabel()
        body.text = "Some text can go here:"
        body.adjustsFontForContentSizeCategory = true
        body.numberOfLines = 0
        let body2 = UILabel()
        body2.text = GDSLocalisedString(stringLiteral: "More text can follow below, too").value
        body2.adjustsFontForContentSizeCategory = true
        body2.numberOfLines = 0
        let stackView = UIStackView(arrangedSubviews: [body, bulletView, body2])
        stackView.axis = .vertical
        stackView.alignment = .top
        stackView.spacing = 12
        return stackView
    }
}
