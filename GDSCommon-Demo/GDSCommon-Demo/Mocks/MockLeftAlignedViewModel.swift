import GDSCommon

struct MockLeftAlignedViewModelNoButtons: GDSLeftAlignedViewModel, BaseViewModel {
    var title: GDSLocalisedString = "Title"
    var bodyContent: [ScreenBodyItem] = [
        BodyTextViewModel(text: GDSLocalisedString(stringLiteral: "some body content")),
        BodyTextViewModel(text: GDSLocalisedString(stringLiteral: "some body content")),
        BodyTextViewModel(text: GDSLocalisedString(stringLiteral: "some body content")),
        MockButtonViewModel(title: "Button", icon: nil, shouldLoadOnTap: false, action: {})
    ]
    var buttonViewModels: [ButtonViewModel] = []
    
    var rightBarButtonTitle: GDSCommon.GDSLocalisedString? = nil
    var backButtonIsHidden: Bool = false
    
    func didAppear() {
        //
    }
    
    func didDismiss() {
        //
    }
}

struct MockLeftAlignedViewModel: GDSLeftAlignedViewModel, BaseViewModel {
    var title: GDSLocalisedString = "Title"
    var bodyContent: [ScreenBodyItem] = [
        BodyTextViewModel(text: GDSLocalisedString(stringLiteral: "some body content")),
        BodyTextViewModel(text: GDSLocalisedString(stringLiteral: "some body content")),
        BodyTextViewModel(text: GDSLocalisedString(stringLiteral: "some body content")),
        MockButtonViewModel(title: "Button", icon: nil, shouldLoadOnTap: false, action: {})
    ]
    var buttonViewModels: [ButtonViewModel] = [
        MockButtonViewModel(title: "Button", icon: nil, shouldLoadOnTap: false, action: {}),
        MockButtonViewModel(title: "Button", icon: nil, shouldLoadOnTap: false, action: {}),
        MockButtonViewModel(title: "Button", icon: nil, shouldLoadOnTap: false, action: {})
    ]
    
    var rightBarButtonTitle: GDSCommon.GDSLocalisedString? = nil
    var backButtonIsHidden: Bool = false
    
    func didAppear() {
        //
    }
    
    func didDismiss() {
        //
    }
}
