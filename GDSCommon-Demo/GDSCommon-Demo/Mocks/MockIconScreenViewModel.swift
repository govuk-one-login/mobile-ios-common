import GDSCommon
import UIKit

public struct MockIconScreenViewModel: IconScreenViewModel, BaseViewModel {
    public let imageName: String = "exclamationmark.circle"
    public let title: GDSLocalisedString = "Example title text"
    public let body: GDSLocalisedString = "Example subtitle text string for testing purposes"
    public let childViews: [UIView]
    public let rightBarButtonTitle: GDSLocalisedString? = "right bar button"
    public var backButtonIsHidden: Bool = false
    
    public func didAppear() { }
    public func didDismiss() { }
    
    public init() {
        let optionViewModel1 = MockOptionViewModel1()
        let optionView1 = OptionView(viewModel: optionViewModel1)
        let optionViewModel2 = MockOptionViewModel2()
        let optionView2 = OptionView(viewModel: optionViewModel2)
        childViews = [optionView1, optionView2]
    }
}
