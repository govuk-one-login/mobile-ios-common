import GDSCommon
import Testing
import UIKit

@MainActor
struct ScreenBodyItemTests {
    @Test
    func bodyTextViewModel() {
        let viewModel = BodyTextViewModel(text: "Test text")
        let label = viewModel.uiView as? UILabel
        #expect(label?.text == "Test text")
        #expect(label?.font == UIFont.body)
        #expect(label?.textAlignment == .center)
        #expect(label?.lineBreakMode == .byWordWrapping)
        #expect(label?.numberOfLines == 0)
    }
    
    func bulletViewModel() throws {
        let viewModel = MockBulletViewModel()
        let view = viewModel.uiView as? BulletView
        #expect(viewModel.uiView is BulletView)
        #expect(view?.titleLabel.text == "test title")
        let bulletLabels: [UILabel] = try view?.bulletLabels as? [UILabel] ?? []
        #expect(bulletLabels.map(\.text) == ["item 1", "item 2", "item 3"])
    }
    
    func buttonViewModel() {
        let viewModel = MockButtonViewModel(title: "button title", action: {})
        let view = viewModel.uiView as? UIButton
        #expect(view?.titleLabel?.text == "button title")
    }
}

@MainActor
struct MockBulletViewModel: BulletViewModel {
    var title: String? = "test title"
    var titleFont: UIFont? = .title3
    var text = ["item 1", "item 2", "item 3"]
}
