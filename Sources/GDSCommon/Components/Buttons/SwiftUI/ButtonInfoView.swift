import SwiftUI

public struct ButtonInfoView: View {
    public let viewModel: ButtonInfoViewModel
    
    public var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.title)
                .bodyHeader()
                .padding(.vertical, 2)
                .padding(.trailing, 16)
            Text(viewModel.body)
                .fixedSize(horizontal: false, vertical: true)
                .foregroundColor(Color(.gdsGrey))
                .padding(.trailing, 16)
            Divider()
                .overlay(Color(.gdsGrey))
            ButtonView(buttonViewModel: viewModel.button)
                .buttonStyle(.support)
                .padding(.trailing, 16)
        }
        .padding(.top, 24)
    }
    
    public init(viewModel: ButtonInfoViewModel) {
        self.viewModel = viewModel
    }
}
