import GDSCommon
import UIKit

struct MockIconScreenViewModel: IconScreenViewModel, BaseViewModel {
    let imageName: String = "exclamationmark.circle"
    let title: GDSLocalisedString = "Example title text"
    let body: GDSLocalisedString = "Example subtitle text string for testing purposes"
    let childViews: [UIView]
    let rightBarButtonTitle: GDSLocalisedString? = "right bar button"
    let backButtonIsHidden: Bool = false
    
    func didAppear() { }
    func didDismiss() { }
    
    init() {
        let optionViewModel1 = MockOptionViewModel1()
        let optionView1 = OptionView(viewModel: optionViewModel1)
        let optionViewModel2 = MockOptionViewModel2()
        let optionView2 = OptionView(viewModel: optionViewModel2)
        childViews = [optionView1, optionView2]
    }
}
