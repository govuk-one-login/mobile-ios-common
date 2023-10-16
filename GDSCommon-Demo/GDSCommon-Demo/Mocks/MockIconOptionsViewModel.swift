import GDSCommon
import UIKit

struct MockIconOptionsViewModel: IconOptionsViewModel {
    let imageName: String = "exclamationmark.circle"
    let title: GDSLocalisedString = "Example title text"
    let body: GDSLocalisedString = "Example subtitle text string for testing purposes"
    let contentViews: [UIView]
    
    init() {
        let optionViewModel1 = MockOptionViewModel()
        let optionView1 = OptionView(viewModel: optionViewModel1)
        let optionViewModel2 = MockOptionViewModel()
        let optionView2 = OptionView(viewModel: optionViewModel2)
        contentViews = [optionView1, optionView2]
    }
}
