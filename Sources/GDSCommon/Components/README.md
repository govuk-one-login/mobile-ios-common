# Components

Save time with reusable, accessible components for buttons and dialog views.

## RoundedButton
Primary button for main actions, it's a green button (by default) with rounded corners and an optional icon. 

The colour of this button is determined by the `Accent` colour of your app. The button can be added via storyboard file or via the codebase.

## ButtonViewModel
To configure a button create an implementation of the `ButtonViewModel` protocol, for example:

```swift
import GDSCommon

struct SupportButtonViewModel: ButtonViewModel {
    let title: GDSLocalisedString = "contactSupportButton"
    let icon: String? = nil
    let shouldLoadOnTap: Bool = false
    let action: (() -> Void)
}
```
`title` can be either a localised String key or a String and `icon` is an SFSymbol name.
 
The `ButtonViewModel` can be added to `UIViewController`. It provides a guideline of the buttons behaviour and the information that is needed, such as, title, optional icon, behaviour when tapped and whether an action should be done after being tapped.

There are two different button types that are used which are rounded and secondary.


### SecondaryButton
The Secondary button is used for non default actions such as contacting support or exiting the journey. To use `SecondaryButton` declare it as the type on the initialise the view directly if you are defining your screens programmatically.
If you are using storyboards set the type of the `IBOutlet` on your `UIViewController` to `SecondaryButton`:
```swift
@IBOutlet private var secondaryButton: SecondaryButton! {
  didSet {
    secondaryButton.setTitle(buttonViewModel.title, for: .normal)
  }
}
```

The purpose is to trigger specific actions or events when tapped by the user and provides a button to match GDS designs guidelines.  

## SymbolPosition
Sets up the image icon on either the left or right of the text within the button by using either `beforeTitle` or `afterTitle` enums. 
For example the symbol position is placed before the text within the `qrCodeButton`.
```swift 
qrCodeButton.symbolPosition = .beforeTitle
```

## DialogView
A translucent modal view that is used for displaying results from user action. It can be configured as a loading indicator or can display success/failed symbols to the user. This component is shared across multiple journeys within the `GOV.UK ID Check` app. 

An example usage is with `loading` where we update the view state after loading completes. 

```swift
let dialogView = DialogView<CheckmarkDialogAccessoryView>(title: "Loading...", isLoading: true)
 
dialogView.present(onViewController: self) {
    print("completed")
}

loadResourceWithCallback() {
    dialogView.updateState(isLoading: false,
                           newTitle: "Scan Complete",
                           viewController: self)
}
```

## BulletView
A view that is used for displaying a list with bullet points. There is the ability to pass through a title and array of text to be displayed in the list. This component is shared across multiple journeys within the `GOV.UK ID Check` app. 

An example usage would be a list of checks for a user to make before completing an action. 

There is the ability to set titleFont like the example below:
```swift
let viewModel = BulletViewModel(title: "Bullet List Title,
                                text: ["First Bullet", "Second Bullet", "Third Bullet],
                                titleFont: = UIFont(style: .title2, weight: .bold))
func addBulletView() {
    let bulletView = BulletView(viewModel: bulletViewModel)
    bulletView.accessibilityIdentifier = "bulletView"
    stackView.addArrangedSubview(bulletView)
}
```

Additionally, there is a default parameter set so titleFont does not need to be passed through.

```swift
let viewModel = BulletViewModel(title: "Bullet List Title,
                                text: ["First Bullet", "Second Bullet", "Third Bullet])
                                
func addBulletView() {
    let bulletView = BulletView(viewModel: bulletViewModel)
    bulletView.accessibilityIdentifier = "bulletView"
    stackView.addArrangedSubview(bulletView)
}
```
