import GDSCommon

internal struct MockButtonViewModel: ButtonViewModel {
    let voiceoverHint: GDSLocalisedString?
    let title: GDSLocalisedString
    let icon: ButtonIconViewModel?
    let shouldLoadOnTap: Bool
    let action: () -> Void
    
    init(title: GDSLocalisedString, icon: ButtonIconViewModel? = nil, shouldLoadOnTap: Bool = false, voiceoverHint: GDSLocalisedString? = nil, action: @escaping () -> Void) {
        self.title = title
        self.icon = icon
        self.shouldLoadOnTap = shouldLoadOnTap
        self.action = action
        self.voiceoverHint = voiceoverHint
    }
}
