import GDSCommon

internal struct MockButtonViewModel: ButtonViewModel {
    let title: GDSLocalisedString
    let icon: String?
    let shouldLoadOnTap: Bool
    let action: () -> Void
    
    init(title: GDSLocalisedString, icon: String? = nil, shouldLoadOnTap: Bool = false, action: @escaping () -> Void) {
        self.title = title
        self.icon = icon
        self.shouldLoadOnTap = shouldLoadOnTap
        self.action = action
    }
}
