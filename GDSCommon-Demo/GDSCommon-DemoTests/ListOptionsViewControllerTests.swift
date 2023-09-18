import GDSCommon
import XCTest

final class ListOptionsViewControllerTests: XCTestCase {
    var sut: ListOptionsViewController!
    var viewModel: ListOptionsViewModel!
    var resultAction: ((GDSLocalisedString) -> Void)!
    var gdsLocalisedString: GDSLocalisedString!
    
    var didSetStringKey: String?
    
    override func setUp() {
        super.setUp()
        gdsLocalisedString = "exampleString"
        
        resultAction = { gdsString in
            self.didSetStringKey = gdsString.stringKey
        }
        
        viewModel = MockListViewModel() { localisedString in
            
        }
        sut = .init(viewModel: viewModel)
    }
    
    override func tearDown() {
        gdsLocalisedString = nil
        resultAction = nil
        viewModel = nil
        sut = nil
        
        super.tearDown()
    }
}

extension ListOptionsViewControllerTests {
    func testResultAction() {
        
        resultAction(gdsLocalisedString)
    }
}

extension ListOptionsViewController {
    var titleLabel: UILabel {
        get throws {
            try XCTUnwrap(view[child: "titleLabel"])
        }
    }
    
    var bodyLabel: UILabel {
        get throws {
            try XCTUnwrap(view[child: "bodyLabel"])
        }
    }
    
    var tableViewList: UITableView {
        get throws {
            try XCTUnwrap(view[child: "tableViewList"])
        }
    }
    
    var primaryButton: RoundedButton {
        get throws {
            try XCTUnwrap(view[child: "primaryButton"])
        }
    }
}
