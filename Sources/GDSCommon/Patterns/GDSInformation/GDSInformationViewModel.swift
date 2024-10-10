@available(*, deprecated, renamed: "GDSInformationViewModelV2", message: "Should conform to additional protocols if additional configuration is required")
public typealias GDSInformationViewModel = GDSInformationViewModelV2 &
                                           GDSInformationViewModelWithOptionalFootnote &
                                           GDSInformationViewModelPrimaryButton &
                                           GDSInformationViewModelWithOptionalSecondaryButton

@available(*, deprecated, renamed: "GDSInformationViewModelWithFootnote", message: "Should swap to non-optional alternative")
@MainActor
public protocol GDSInformationViewModelWithOptionalFootnote {
    var footnote: GDSLocalisedString? { get }
}

@available(*, deprecated, renamed: "GDSInformationViewModelPrimaryButton", message: "Should swap to non-optional alternative")
@MainActor
public protocol GDSInformationViewModelWithOptionalPrimaryButton {
    var primaryButtonViewModel: ButtonViewModel? { get }
}

@available(*, deprecated, renamed: "GDSInformationViewModelWithSecondaryButton", message: "Should swap to non-optional alternative")
@MainActor
public protocol GDSInformationViewModelWithOptionalSecondaryButton {
    var secondaryButtonViewModel: ButtonViewModel? { get }
}
