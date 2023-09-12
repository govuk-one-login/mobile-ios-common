import UIKit

public protocol DialogPresenter {
    func present(onView view: UIView) async
    func updateState(isLoading: Bool, newTitle: String, view: UIView) async
    func remove(view: UIView) async
}
