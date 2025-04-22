import UIKit

public typealias TitleConfig = (font: UIFont, isHeader: Bool)

@MainActor
public protocol NumberedListViewModel {
    var title: GDSLocalisedString? { get }
    var titleConfig: TitleConfig? { get }
    var listItemStrings: [GDSLocalisedString] { get }
}
