import GDSCommon
import UIKit

/// Screens
///
/// To add a new `Screens` attribute
/// - add a new case for the view
/// - declare if it should be modal in presentation
/// - create a static var for the UIViewController to be presented
///
/// - Returns: - The view name as a `String`
///             isModal as a `Bool` to determine if it should be presented modally, the default is false
///             the view as a `UIViewController` to push/present on the navigation stack.
enum Screens: CaseIterable {
    case gdsInstructions
    case gdsInstructionsWithImage
    case gdsModalInfoView
    case gdsListOptions
    case gdsIntroView
    case gdsQRCodeScanner
    case gdsQRCodeScannerModal
    
    var name: String {
        switch self {
        case .gdsInstructions:
            return "GDS Instructions View"
        case .gdsInstructionsWithImage:
            return "GDS Instructions View (with image)"
        case .gdsModalInfoView:
            return "Modal Info View"
        case .gdsListOptions:
            return "List Options"
        case .gdsIntroView:
            return "Intro View"
        case .gdsQRCodeScanner:
            return "QR Code Scanner"
        case .gdsQRCodeScannerModal:
            return "QR Code Scanner (Modal)"
        }
    }
    
    var isModal: Bool {
        switch self {
        case .gdsModalInfoView, .gdsQRCodeScannerModal:
            return true
        default:
            return false
        }
    }
    
    private var mockButtonViewModel: ButtonViewModel {
        MockButtonViewModel(title: "Action Button", shouldLoadOnTap: false, action: {})
    }
    
    var view: UIViewController {
        switch self {
        case .gdsInstructions:
            let viewModel = MockGDSInstructionsViewModel(buttonViewModel: mockButtonViewModel)
            return GDSInstructionsViewController(viewModel: viewModel)
        case .gdsInstructionsWithImage:
            let viewModel = MockInstructionsWithImageViewModel(warningButtonViewModel: mockButtonViewModel,
                                                               primaryButtonViewModel: mockButtonViewModel,
                                                               screenView: {})
            return InstructionsWithImageViewController(viewModel: viewModel)
        case .gdsModalInfoView:
            let viewModel = MockModalInfoViewModel()
            let view = ModalInfoViewController(viewModel: viewModel)
            view.isModalInPresentation = true
            return view
        case .gdsListOptions:
            let viewModel = MockListViewModel()
            return ListOptionsViewController(viewModel: viewModel)
        case .gdsIntroView:
            let viewModel = MockIntroViewModel(introButtonViewModel: mockButtonViewModel)
            return IntroViewController(viewModel: viewModel)
        case .gdsQRCodeScanner:
            let viewModel = MockQRScanningViewModel(format: "ABC123")
            let vc = ScanningViewController(scanningController: self,
                                            viewModel: viewModel)
            return vc
        case .gdsQRCodeScannerModal:
            let viewModel = MockQRScanningViewModel(format: "ABC123")
            let vc = ScanningViewController(scanningController: self,
                                            viewModel: viewModel)
            return vc
        }
    }
}

// Conforming to ScanningController, to get callbacks for events.
extension Screens: ScanningController {
    func completeScan(url: URL) {
        print("Scan Complete - \(url.absoluteString)")
    }
    
    func scanCompleteWithError(url: URL?) {
        if let url {
            print("Scan Complete, with Errors - \(url.absoluteString)")
        } else {
            print("Scan Complete, with Errors - no URL found")
        }
    }
}
