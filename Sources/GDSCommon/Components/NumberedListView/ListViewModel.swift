import UIKit

public typealias TitleConfig = (font: UIFont, isHeader: Bool)

@MainActor
public protocol ListViewModel {
    var title: GDSLocalisedString? { get }
    var titleConfig: TitleConfig? { get }
    var listItemStrings: [GDSLocalisedString] { get }
}
