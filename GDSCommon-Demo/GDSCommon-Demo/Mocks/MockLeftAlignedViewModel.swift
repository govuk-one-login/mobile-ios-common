import GDSCommon
import UIKit

struct MockLeftAlignedViewModel: GDSLeftAlignedViewModel, BaseViewModel {
    let title: GDSLocalisedString = "This is a Left Aligned Screen title"
    let bodyContent: [ScreenBodyItem]
    let buttonViewModels: [ButtonViewModel]
    let rightBarButtonTitle: GDSLocalisedString? = "cancel"
    let backButtonIsHidden: Bool = false
    
    let appearAction: () -> Void
    let dismissAction: () -> Void
    
    func didAppear() {
        appearAction()
    }
    
    func didDismiss() {
        dismissAction()
    }
}

struct MockLeftAlignedViewModelNoButtons: GDSLeftAlignedViewModel, BaseViewModel {
    let title: GDSLocalisedString = "Left aligned screen title"
    let bodyContent: [ScreenBodyItem] = [
        BodyTextViewModel(text: GDSLocalisedString(stringLiteral: "This screen has no buttons at the bottom"), overridingAlignment: .left),
        BodyTextViewModel(text: GDSLocalisedString(stringLiteral: "some body content"), overridingAlignment: .left),
        BodyHeadingViewModel(text: GDSLocalisedString(stringLiteral: "This is a heading in body"), overridingAlignment: .left),
        BodyTextViewModel(text: GDSLocalisedString(stringLiteral: "some body content"), overridingAlignment: .left),
        MockButtonViewModel(title: "Button", icon: nil, shouldLoadOnTap: false, action: {}, overrideContentAlignment: .leading)
    ]
    let buttonViewModels: [ButtonViewModel] = []
    
    let rightBarButtonTitle: GDSCommon.GDSLocalisedString? = nil
    let backButtonIsHidden: Bool = false
    
    func didAppear() {
        //
    }
    
    func didDismiss() {
        //
    }
}

struct MockLeftAlignedViewModelWith3Buttons: GDSLeftAlignedViewModel, BaseViewModel {
    let title: GDSLocalisedString = "Left aligned screen title"
    let bodyContent: [ScreenBodyItem] = [
        BodyTextViewModel(text: GDSLocalisedString(stringLiteral: "This screen has 3 buttons at the bottom"), overridingAlignment: .left),
        BodyTextViewModel(text: GDSLocalisedString(stringLiteral: "some body content"), overridingAlignment: .left),
        BodyTextViewModel(text: GDSLocalisedString(stringLiteral: "some body content"), overridingAlignment: .left),
        MockButtonViewModel(
            title: "Button with really long button label so that it wraps",
            icon: nil,
            shouldLoadOnTap: false,
            action: {
            },
            overrideContentAlignment: .leading)
    ]
    let buttonViewModels: [ButtonViewModel] = [
        MockButtonViewModel(title: "Button 1", icon: nil, shouldLoadOnTap: false, action: {}),
        MockButtonViewModel(title: "Button 2", icon: nil, shouldLoadOnTap: false, action: {}),
        MockButtonViewModel(title: "Button 3", icon: nil, shouldLoadOnTap: false, action: {})
    ]
    
    let rightBarButtonTitle: GDSCommon.GDSLocalisedString? = nil
    let backButtonIsHidden: Bool = false
    
    func didAppear() {
        //
    }
    
    func didDismiss() {
        //
    }
}

struct MockLeftAlignedViewModelWithImages: GDSLeftAlignedViewModel, BaseViewModel {
    let title: GDSLocalisedString = "Left aligned screen title"
    let bodyContent: [ScreenBodyItem] = [
        BodyTextViewModel(text: GDSLocalisedString(stringLiteral: "This screen has no buttons at the bottom"), overridingAlignment: .left),
        BodyImageViewModel(image: .placeholder),
        BodyTextViewModel(text: GDSLocalisedString(stringLiteral: "some body content"), overridingAlignment: .left),
        BodyImageViewModel(image: .placeholder),
        MockButtonViewModel(title: "Button", icon: nil, shouldLoadOnTap: false, action: {}, overrideContentAlignment: .leading)
    ]
    let buttonViewModels: [ButtonViewModel] = [
        MockButtonViewModel(title: "Button 1", icon: nil, shouldLoadOnTap: false, action: {}),
        MockButtonViewModel(title: "Button 2", icon: nil, shouldLoadOnTap: false, action: {}),
        MockButtonViewModel(title: "Button 3", icon: nil, shouldLoadOnTap: false, action: {})
    ]
    
    let rightBarButtonTitle: GDSCommon.GDSLocalisedString? = nil
    let backButtonIsHidden: Bool = false
    
    func didAppear() {
        //
    }
    
    func didDismiss() {
        //
    }
}
