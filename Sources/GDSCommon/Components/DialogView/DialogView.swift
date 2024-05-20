/*
 MARK: Example Usage
 
 private func presentLoadingDialogView() {
     let dialogView = DialogView<CheckmarkDialogAccessoryView>(title: "Loading...", isLoading: true)
     
     dialogView.present(onViewController: self) {
         print("completed")
     }

     DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
         dialogView.updateState(isLoading: false, newTitle: "Scan Complete", viewController: self)
     }
 }
 
 `private func presentDialogView() {
     let dialogView = DialogView<CheckmarkDialogAccessoryView>(title: "Scan Complete", isLoading: false)
     dialogView.present(onViewController: self) {
         print("completed")
     }
 }
 
 */

import UIKit

public protocol DialogAccessoryView: UIView {
    func playAnimation()
    func playLoadingAnimation()
    
    func updateLoadingState(isLoading: Bool)
}

public final class DialogView<T: DialogAccessoryView>: NibView {
    private let initialTransformation = CGAffineTransform.identity
        .scaledBy(x: 0.9, y: 0.9).translatedBy(x: 0, y: 0)
    private let displayTransformation = CGAffineTransform.identity
    
    private let displayTime: TimeInterval = 1.5
    
    private(set) var isLoading: Bool {
        didSet {
            accessoryView.updateLoadingState(isLoading: isLoading)
        }
    }
    
    @IBOutlet private var contentView: UIView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var accessoryViewContainer: UIView!
    
    public let accessoryView: CheckmarkDialogAccessoryView
    private(set) var completionHandler: (() -> Void)?
    
    public init(title: String, isLoading: Bool) {
        accessoryView = .init(isLoading: isLoading)
        accessoryView.accessibilityIdentifier = "accessoryView"
        
        self.isLoading = isLoading
        super.init(frame: .zero, forcedNibName: "DialogView", bundle: .module)
        
        titleLabel.text = title
        titleLabel.textAlignment = .center
        titleLabel.textColor = .dialogText
        titleLabel.font = .init(style: .body, weight: .bold)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.accessibilityIdentifier = "titleLabel"
        
        contentView.layer.cornerRadius = 12
        contentView.accessibilityIdentifier = "contentView"
        
        accessoryViewContainer.addSubview(accessoryView,
                                          insetBy: .zero)
        accessoryViewContainer.accessibilityIdentifier = "accessoryViewContainer"

    }
    
    public func present(onView view: UIView,
                        shouldLoad: Bool? = nil,
                        title: String? = nil,
                        withCompletionHandler handler: (() -> Void)? = nil) {
        
        if let shouldLoad {
            self.isLoading = shouldLoad
        }
        
        if let title {
            titleLabel.text = title
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        center = .init(x: view.bounds.width / 2,
                       y: view.bounds.height / 2)
        
        transform = initialTransformation
        alpha = 0
        
        view.addSubview(self)
        
        view.isUserInteractionEnabled = false
        
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(greaterThanOrEqualToConstant: 156),
            self.heightAnchor.constraint(greaterThanOrEqualToConstant: 159),
            self.widthAnchor.constraint(lessThanOrEqualToConstant: view.frame.width - 12),
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0)
        ])
        
        self.completionHandler = handler
        
        playPresentationAnimations(view: view, isLoading: isLoading)
    }
    
    public func updateState(isLoading: Bool, newTitle: String, view: UIView, withCompletionHandler handler: (() -> Void)? = nil) {
        self.isLoading = isLoading
        titleLabel.text = newTitle
        
        self.completionHandler = handler
        
        playPresentationAnimations(view: view, isLoading: isLoading)
    }
    
    public func remove(view: UIView, withCompletionHandler handler: (() -> Void)? = nil) {
        self.completionHandler = handler
        self.playDismissAnimations(withDelay: 2)
        view.isUserInteractionEnabled = true
    }
    
    private func playPresentationAnimations(view: UIView,
                                            isLoading: Bool = false) {
        guard !isLoading else {
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn) {
                self.transform = self.displayTransformation
                self.alpha = 1
            } completion: {  _ in
                self.accessoryView.playLoadingAnimation()
                self.completionHandler?()
                self.completionHandler = nil
            }
            return
        }
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn) {
            self.transform = self.displayTransformation
            self.alpha = 1
        } completion: { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.accessoryView.playAnimation()
                DispatchQueue.main.asyncAfter(deadline: .now() + self.displayTime) {
                    self.playDismissAnimations()
                    view.isUserInteractionEnabled = true
                }
            }
        }
    }
    
    private func playDismissAnimations(withDelay delay: Double = 0) {
        UIView.animate(withDuration: 0.2, delay: delay, options: .curveEaseInOut) {
            self.transform = self.initialTransformation
            self.alpha = 0
        } completion: { _ in
            self.removeFromSuperview()
            self.completionHandler?()
            self.completionHandler = nil
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("Please initialize from 'init(title: String, subtitle: String)'")
    }
}

// MARK: Async Await
extension DialogView: DialogPresenter {
    @MainActor
    public func present(onView view: UIView,
                        shouldLoad: Bool? = nil,
                        title: String? = nil) async {
        await withCheckedContinuation { continuation in
            present(onView: view,
                    shouldLoad: shouldLoad,
                    title: title,
                    withCompletionHandler: continuation.resume)
        }
    }
    
    @MainActor
    public func updateState(isLoading: Bool, newTitle: String, view: UIView) async {
        await withCheckedContinuation { continuation in
            updateState(isLoading: isLoading,
                        newTitle: newTitle,
                        view: view,
                        withCompletionHandler: continuation.resume)
        }
    }
    
    @MainActor
    public func remove(view: UIView) async {
        await withCheckedContinuation { continuation in
            remove(view: view, withCompletionHandler: continuation.resume)
        }
    }
}
