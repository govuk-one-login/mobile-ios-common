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
    
    @Test
    func bodyHeadingViewModel() {
        let viewModel = BodyHeadingViewModel(text: "Test text")
        let label = viewModel.uiView as? UILabel
        #expect(label?.text == "Test text")
        #expect(label?.font == UIFont.bodySemiBold)
        #expect(label?.textAlignment == .center)
        #expect(label?.lineBreakMode == .byWordWrapping)
        #expect(label?.numberOfLines == 0)
        #expect(label?.accessibilityTraits == .header)
    }
    
    @Test
    func bulletViewModel() throws {
        let viewModel = MockBulletViewModel()
        let view = viewModel.uiView as? BulletView
        #expect(viewModel.uiView is BulletView)
        #expect(view?.titleLabel.text == "test title")
        let bulletLabels: [UILabel] = try view?.bulletLabels as? [UILabel] ?? []
        #expect(view?.titleLabel.font == .title3Bold)
        #expect(bulletLabels.map(\.text) == ["\t●\titem 1", "\t●\titem 2", "\t●\titem 3"])
    }
    
    @Test
    func buttonViewModel() {
        let viewModel = MockButtonViewModel(title: "button title", action: {})
        let view = viewModel.uiView as? UIButton
        #expect(view?.titleLabel?.text == "button title")
    }
    
    @Test
    func imageViewModel() {
        let viewModel = BodyImageViewModel(image: UIImage())
        #expect(viewModel.uiView is UIImageView)
    }
}
