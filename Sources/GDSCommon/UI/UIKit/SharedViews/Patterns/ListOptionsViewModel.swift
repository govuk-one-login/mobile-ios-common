import Foundation

public protocol ListOptionsViewModel {
    var title: GDSLocalisedString { get }
    var body: String? { get }
    var listRows: [GDSLocalisedString] { get }
    var listHeader: String? { get }
    var listFooter: String? { get }
    var buttonViewModel: ButtonViewModel { get }
    var resultAction: (GDSLocalisedString) -> Void { get }
    
    func didAppear()
}
