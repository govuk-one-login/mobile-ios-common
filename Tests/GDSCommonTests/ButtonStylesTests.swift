@testable import GDSCommon

import SwiftUI
import ViewInspector
import XCTest

final class ButtonStylesTests: XCTestCase {}

extension ButtonStylesTests {
    
    @MainActor
    func test_primaryButtonSetup() throws {
        let sut = ButtonView(buttonViewModel: MockButtonViewModel(title: "", action: { }))
            .buttonStyle(.primary)
        XCTAssertTrue(try sut.inspect().buttonStyle() is Primary)
    }
    
    @MainActor
    func test_primaryButton() throws {
        let sut = try Primary().inspect(isPressed: false)
        
        print(try sut.styleConfigurationLabel().fixedSize())
        
        XCTAssertFalse(try sut.fixedSize().horizontal)
        XCTAssertTrue(try sut.fixedSize().vertical)
        
        XCTAssertEqual(try sut.styleConfigurationLabel(0).multilineTextAlignment(), .center)
        XCTAssertEqual(try sut.styleConfigurationLabel(0).foregroundColor(), .white.opacity(1))
        XCTAssertEqual(try sut.flexFrame().maxWidth, .infinity)
        XCTAssertEqual(try sut.flexFrame().minHeight, 44)
        XCTAssertEqual(try sut.styleConfigurationLabel(0).font(), Font.body.weight(.semibold))
        XCTAssertEqual(try sut.cornerRadius(), 16)
    }
    
    @MainActor
    func test_secondaryButtonSetup() throws {
        let sut = ButtonView(buttonViewModel: MockButtonViewModel(title: "", action: { }))
            .buttonStyle(.secondary)
        
        XCTAssertTrue(try sut.inspect().buttonStyle() is Secondary)
    }
    
    @MainActor
    func test_secondaryButton() throws {
        let sut = try Secondary().inspect(isPressed: false)
        
        XCTAssertFalse(try sut.fixedSize().horizontal)
        XCTAssertTrue(try sut.fixedSize().vertical)
        
        XCTAssertEqual(try sut.styleConfigurationLabel(0).multilineTextAlignment(), .center)
        XCTAssertEqual(try sut.styleConfigurationLabel(0).foregroundColor(), Color(.accent).opacity(1))
        XCTAssertEqual(try sut.flexFrame().maxWidth, .infinity)
        XCTAssertEqual(try sut.flexFrame().minHeight, 44)
    }
    
    @MainActor
    func test_supportButtonSetup() throws {
        let sut = ButtonView(buttonViewModel: MockButtonViewModel(title: "", action: { }))
            .buttonStyle(.support)
        
        XCTAssertTrue(try sut.inspect().buttonStyle() is Support)
    }
    
    @MainActor
    func test_supportButton() throws {
        let sut = try Support().inspect(isPressed: false)
        
        XCTAssertFalse(try sut.fixedSize().horizontal)
        XCTAssertTrue(try sut.fixedSize().vertical)
        
        XCTAssertEqual(try sut.styleConfigurationLabel(0).multilineTextAlignment(), .leading)
        XCTAssertEqual(try sut.styleConfigurationLabel(0).foregroundColor(), Color(.accent).opacity(1))
        XCTAssertEqual(try sut.flexFrame().alignment, .leading)
        XCTAssertEqual(try sut.flexFrame().minHeight, 24)
    }
}
