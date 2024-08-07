import Foundation

@MainActor
public protocol ButtonInfoViewModel {
    var title: String { get }
    var body: String { get }
    var button: ButtonViewModel { get }
}
