import GDSCommon
@testable import GDSCommon_Demo
import UIKit

class MockDialogPresenter: DialogPresenter {
    var didCallPresent = false
    var didCallUpdate = false
    var didCallRemove = false
    
    var isLoading = false
    
    func present(onView view: UIView, shouldLoad: Bool?, title: String?) async {
        if let shouldLoad {
            self.isLoading = shouldLoad
        }
        didCallPresent = true
    }
    
    func updateState(isLoading: Bool, newTitle: String, view: UIView) async {
        self.isLoading = isLoading
        didCallUpdate = true
    }
    
    func remove(view: UIView) async {
        didCallRemove = true
    }
}
