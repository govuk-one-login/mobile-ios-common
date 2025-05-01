import GDSCommon

struct MockLeftAlignedViewModelNoButtons: GDSLeftAlignedViewModel, BaseViewModel {
    let title: GDSLocalisedString = "Left aligned screen title"
    let bodyContent: [ScreenBodyItem] = [
        BodyTextViewModel(text: GDSLocalisedString(stringLiteral: "This screen has no buttons at the bottom"), overridingAlignment: .left),
        BodyTextViewModel(text: GDSLocalisedString(stringLiteral: "some body content"), overridingAlignment: .left),
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

struct MockLeftAlignedViewModel: GDSLeftAlignedViewModel, BaseViewModel {
    let title: GDSLocalisedString = "Left aligned screen title"
    let bodyContent: [ScreenBodyItem] = [
        BodyTextViewModel(text: GDSLocalisedString(stringLiteral: "This screen has 3 buttons at the bottom"), overridingAlignment: .left),
        BodyTextViewModel(text: GDSLocalisedString(stringLiteral: "some body content"), overridingAlignment: .left),
        BodyTextViewModel(text: GDSLocalisedString(stringLiteral: "some body content"), overridingAlignment: .left),
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
