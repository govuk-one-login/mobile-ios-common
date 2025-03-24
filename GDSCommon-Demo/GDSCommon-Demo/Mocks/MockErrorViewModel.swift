import GDSCommon
import UIKit

var singleLineRegular: ScreenBodyItem {
    BodyTextViewModel(
        text: "Body single line (regular)"
    )
}

var singleLineBold: ScreenBodyItem {
    BodyTextViewModel(
        text: "Body single line (body)",
        fontWeight: .bold
    )
}

var singleParagraph: ScreenBodyItem {
    BodyTextViewModel(
        text: "Body single paragraph - Lorem ipsum dolor sit amet consectetur. Purus aliquam mattis vitae enim mauris vestibulum massa tellus.)"
    )
}
 
var multipleParagraph: ScreenBodyItem {
    BodyTextViewModel(
        text:
        """
            Body multiple paragraphs - Lorem ipsum dolor sit amet consectetur.
            
            Purus aliquam mattis vitae enim mauris vestibulum massa tellus.
        """
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

struct MockErrorViewModelV3WithNoButtons: GDSErrorViewModelV3, BaseViewModel {
    var image: ErrorScreenImage = .error
    let title: GDSLocalisedString = "This is an Error View title"
    let rightBarButtonTitle: GDSLocalisedString? = nil
    let backButtonIsHidden: Bool = false
    
    var bodyContent: [ScreenBodyItem] = [
        singleLineRegular,
        singleParagraph,
        MockBulletViewModel(),
        MockButtonViewModel.textLeading
    ]
    var buttonViewModels: [any ButtonViewModel] = []
    
    func didAppear() {}
    func didDismiss() {}
}

struct MockErrorViewModelV3WithTwoButtons: GDSErrorViewModelV3, BaseViewModel {
    var image: ErrorScreenImage = .error
    let title: GDSLocalisedString = "This is an Error View title"
    let rightBarButtonTitle: GDSLocalisedString? = nil
    let backButtonIsHidden: Bool = false
    
    var bodyContent: [ScreenBodyItem] = [
        singleLineRegular,
        multipleParagraph,
        MockButtonViewModel.textCentered
    ]
    
    var buttonViewModels: [any ButtonViewModel] = [
        MockButtonViewModel.primary,
        MockButtonViewModel.secondary
    ]
    
    func didAppear() {}
    func didDismiss() {}
}

struct MockErrorViewModelV3WithThreeButtons: GDSErrorViewModelV3, BaseViewModel {
    var image: ErrorScreenImage = .error
    let title: GDSLocalisedString = "This is an Error View title"
    
    let rightBarButtonTitle: GDSLocalisedString? = nil
    let backButtonIsHidden: Bool = false
    
    var bodyContent: [ScreenBodyItem] = [
        singleLineRegular,
        singleParagraph,
        MockButtonViewModel.textCentered
    ]
    
    var buttonViewModels: [any ButtonViewModel] = [
        MockButtonViewModel.primary,
        MockButtonViewModel.secondary,
        MockButtonViewModel.tertiary
    ]
    
    func didAppear() {}
    func didDismiss() {}
}

struct MockErrorViewModelV3Modal: GDSErrorViewModelV3, BaseViewModel {
    var image: ErrorScreenImage = .error
    let title: GDSLocalisedString = "This is an modal Error View title"
    let rightBarButtonTitle: GDSLocalisedString? = "Cancel"
    let backButtonIsHidden: Bool = false
    
    var bodyContent: [ScreenBodyItem] = [
        singleLineRegular,
        singleParagraph,
        MockBulletViewModel(),
        MockButtonViewModel.textLeading
    ]
    var buttonViewModels: [any ButtonViewModel] = [
        MockButtonViewModel.primary,
        MockButtonViewModel.secondary
    ]
    
    func didAppear() {}
    func didDismiss() {}
}

struct MockErrorViewModelV3Warning: GDSErrorViewModelV3, BaseViewModel {
    var image: ErrorScreenImage = .warning
    let title: GDSLocalisedString = "This is an Warning Error View title"
    let rightBarButtonTitle: GDSLocalisedString? = nil
    let backButtonIsHidden: Bool = false
    
    var bodyContent: [ScreenBodyItem] = [
        singleLineBold,
        singleParagraph,
        MockButtonViewModel.textCentered
    ]
    
    var buttonViewModels: [any ButtonViewModel] = [
        MockButtonViewModel.primary,
        MockButtonViewModel.secondary
    ]
    
    func didAppear() {}
    func didDismiss() {}
}

struct MockErrorViewModelV3AppUpdate: GDSErrorViewModelV3, BaseViewModel {
    var image: ErrorScreenImage = .appUpdate
    let title: GDSLocalisedString = "This is an App Update Error View title"
    let rightBarButtonTitle: GDSLocalisedString? = nil
    let backButtonIsHidden: Bool = false
    
    var bodyContent: [ScreenBodyItem] = [
        singleLineRegular,
        singleParagraph,
        MockButtonViewModel.textCentered
    ]
    
    var buttonViewModels: [any ButtonViewModel] = [
        MockButtonViewModel.primary
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
