import GDSCommon
import XCTest

internal final class ContentTileViewTests: XCTestCase {
    var sut: ContentTileView!
    var viewModel: ContentTile!
    
    @MainActor 
    override func setUp() {
        super.setUp()
        viewModel = MockContentTileViewModel()
        sut = .init(frame: .zero, viewModel: viewModel)
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
}

@MainActor
extension ContentTileViewTests {
    func test_captionContents() {
        XCTAssertEqual(viewModel.caption.value, "test caption")
    }
    
    func test_titleContents() {
        XCTAssertEqual(viewModel.title.value, "test title")
    }
    
    func test_bodyContents() {
        XCTAssertEqual(viewModel.body.value, "test body")
    }
}

extension ContentTileView {
    var image: UIImageView {
        get throws {
            try XCTUnwrap(self[child: "content-tile-image"])
        }
    }
    
    var captionLabel: UILabel {
        get throws {
            try XCTUnwrap(self[child: "content-tile-caption"])
        }
    }
    
    var titleLabel: UILabel {
        get throws {
            try XCTUnwrap(self[child: "content-tile-title"])
        }
    }
    
    var bodyLabel: UILabel {
        get throws {
            try XCTUnwrap(self[child: "content-tile-body"])
        }
    }
    
    var secondaryButton: SecondaryButton {
        get throws {
            try XCTUnwrap(self[child: "content-secondary-button"])
        }
    }
    
    var primaryButton: RoundedButton {
        get throws {
            try XCTUnwrap(self[child: "content-primary-button"])
        }
    }
}
