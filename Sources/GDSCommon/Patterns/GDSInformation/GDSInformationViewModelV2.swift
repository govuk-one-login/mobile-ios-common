import UIKit

@available(*, deprecated,
            renamed: "CentreAlignedViewModel",
            message: "Should conform to CentreAlignedViewModel and CentreAlignedViewModelWithImage")
public typealias GDSInformationViewModelV2 = GDSCentreAlignedViewModel & GDSCentreAlignedViewModelWithImage

@available(*, deprecated,
            renamed: "CentreAlignedViewModelWithFootnote",
            message: "Should conform to CentreAlignedViewModelWithFootnote instead")
public typealias GDSInformationViewModelWithFootnote = GDSCentreAlignedViewModelWithFootnote

@available(*, deprecated,
            renamed: "CentreAlignedViewModelWithPrimaryButton",
            message: "Should conform to CentreAlignedViewModelWithPrimaryButton instead")
public typealias GDSInformationViewModelPrimaryButton = GDSCentreAlignedViewModelWithPrimaryButton

@available(*, deprecated,
            renamed: "CentreAlignedViewModelWithSecondaryButton",
            message: "Should conform to CentreAlignedViewModelWithSecondaryButton instead")
public typealias GDSInformationViewModelWithSecondaryButton = GDSCentreAlignedViewModelWithSecondaryButton

@available(*, deprecated,
            renamed: "CentreAlignedViewModelWithChildView",
            message: "Should conform to CentreAlignedViewModelWithChildView instead")
public typealias GDSInformationViewModelWithChildView = GDSCentreAlignedViewModelWithChildView
