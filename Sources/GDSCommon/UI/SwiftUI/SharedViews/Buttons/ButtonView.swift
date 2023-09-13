import SwiftUI

// TODO: DCMAW-5307 Look into @BackDeployment (available in swift 5.8) to remove `if available` flags for iOS 13

// TODO: DCMAW-5316 Handle focus state for full keyboard access
public struct ButtonView: View {
    public let buttonViewModel: ButtonViewModel
    public let shouldLoadOnTap: Bool
    
    @State private var isLoading: Bool = false
    
    public var body: some View {
        Button {
            buttonViewModel.action()
            isLoading = true
        } label: {
            if #available(iOS 14.0, *) {
                if isLoading && shouldLoadOnTap {
                    ProgressView()
                        .padding(5)
                } else {
                    if let icon = buttonViewModel.icon {
                        Text("\(buttonViewModel.title.value)\u{00A0}\(Image(systemName: icon))")
                    } else {
                        Text(buttonViewModel.title.value)
                    }
                }
            } else {
                if isLoading && shouldLoadOnTap {
                    Text(NSLocalizedString(key: "oAuth_loading_label"))
                } else {
                    Text(buttonViewModel.title.value)
                    if let icon = buttonViewModel.icon {
                        Image(systemName: icon)
                    }
                }
            }
            
        }
        .disabled(isLoading && shouldLoadOnTap)
        .onAppear {
            isLoading = false
        }
    }
    
    public init(buttonViewModel: ButtonViewModel,
                shouldLoadOnTap: Bool = false) {
        self.buttonViewModel = buttonViewModel
        self.shouldLoadOnTap = shouldLoadOnTap
    }
}
