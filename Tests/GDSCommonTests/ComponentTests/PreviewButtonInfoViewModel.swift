#if DEBUG
import GDSCommon

struct PreviewButtonInfoViewModel: ButtonInfoViewModel {
    let title: String = "Title text"
    let body: String = """
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore
"""
    let button: ButtonViewModel
    let analyticsParams: [String: Any]
    
    init(action: (() -> Void)? = nil) {
        button = MockButtonViewModel(title: "Button title") {
            print("Preview button was tapped")
            action?()
        }
        analyticsParams = ["text": self.title,
                           "type": "preview event type"]
    }
}
#endif
