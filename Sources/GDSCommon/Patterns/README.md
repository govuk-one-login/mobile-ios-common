# Patterns

## BaseViewController

``BaseViewController`` inherits from `UIViewController`. ``BaseViewController`` includes the repetitive code that all screens should have to avoid repetition and reduce risk of missing important functionality and to make it easier to amend, or fix defects if they arise.

Screen view controllers should generally inherit from ``BaseViewController`` instead of `UIViewController` unless the functionality of the screen needs to be intentionally different from standard screens.

### To use:

Once inheriting from ``BaseViewController`` and adding conformance to ``BaseViewModel`` to concrete view model, in the future do not add the following properties and methods to view model protocols:

```swift
var rightBarButtonTitle: GDSLocalisedString? { get }
var backButtonIsHidden: Bool { get }
func didAppear()
func didDismiss()
```
Instead, when creating concrete implementations of view models, conform the concrete implementations to the view model protocol _and_ to the ``BaseViewModel`` protocol. ``BaseViewModel`` includes the above properties and methods.

As long as the view controller inherits from ``BaseViewController`` instead of `UIViewController`, these will be handled without any additional code.

### Example

```swift
public final class ExampleViewController: BaseViewController {
...
    public init(viewModel: ExampleInfoViewModel) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel as? BaseViewModel, nibName: "ExampleInfoView", bundle: .module)
    }
...
}

public protocol ExampleInfoViewModel {
    var title: GDSLocalisedString { get }
    var body: GDSLocalisedString { get }
}

// concrete view model within app:
struct ConcreteModalInfoViewModel: ExampleInfoViewModel, BaseViewModel {
    var title: GDSLocalisedString  = "title"
    var body: GDSLocalisedString = "body"
    var rightBarButtonTitle: GDSLocalisedString = "right bar button"

    func didAppear() { }
    func didDismiss() { }
}
```

## GDSInstructions
This screen includes the following views:
- `titleLabel` (type: `UILabel`)
- `bodyLabel` (type: `UILabel`)
- `stackView` (type: `UIStackView`)
- `primaryButton`  (type: ``RoundedButton`` inherits from SecondaryButton)
- `secondaryButton`  (type: optional ``SecondaryButton`` inherits from UIButton)
    
This screen is typically used to provides bullet list instructions below a heading and body text.
Within the storyboard, these are within two `UIStackView`s which is in turn within a `UIScrollView`.

The `titleLabel` and `bodyLabel` are within `stackView`. The view controller adds the `childView` from the `viewModel`. The `childView` is of type `UIView` so this is flexible. Typically it is used with `BulletView` to provide a bulleted list of instructions.

The `primaryButton` is within a `UIStackView` constrained to the bottom of the screen. This is the primary Call To Action (CTA) on this screen.
The content on the screen is set from the `viewModel`, which must conform to the `GDSInstructionsViewModel` protocol.


## Instruction Screen With Image
This screen includes the following views:
- `titleLabel` (type: `UILabel`)
- `bodyLabel` (type: `UILabel`)
- `imageView` (type: `UIImageView`)
- `warningButton`  (type: ``SecondaryButton`` inherits from `UIButton`)
- `primaryButton`  (type: ``RoundedButton`` inherits from ``SecondaryButton``)
    
This screen provides instructions below a heading and a full width image below the
instructions. Within the storyboard, these are within two `UIStackView`s which is
in turn within a `UIScrollView`. The `primaryButton` is within a `UIStackView` constrained to the bottom of the screen. This is the main Call To Action (CTA) on this screen.
The content on the screen is set from the `viewModel`, which must conform to the `InstructionsWithImageViewModel` protocol.


## PopoverTableViewController

``PopoverTableViewController`` inherits from `UIViewController`. This allows showing a list, as a popover giving the user multiple options from one button. To use this the view controller will need to conform to `UIPopoverPresentationControllerDelegate`.

This screen includes the following views:
- `tableView` (type: `UITableView`)

The content on the screen is set from the `viewModel`, which must conform to the `PopoverItemViewModel` protocol.

### Example

```swift

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = .init(image: UIImage(systemName: "ellipsis.circle"),
                                                       style: .plain,
                                                       target: self,
                                                       action: #selector(openDetailView(_:)))
    }

    func openDetailView(_ sender: Any) {
        let vc = PopoverTableViewController(items: [mockItem])
        vc.modalPresentationStyle = .popover
        
        let presentationController = vc.popoverPresentationController
        presentationController?.permittedArrowDirections = .any
        presentationController?.delegate = self
        presentationController?.sourceView = sender as? UIView
        presentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true, completion: nil)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
```


## ListOptions

This screen includes the following views:
- `titleLabel` (type: `UILabel`)
- `bodyLabel` (type: `UILabel`?)
- `stackView` (type: `UIStackView`)
- `footerLabel` (type: `UILabel`?)
- `tableTitleLabel` (type: `UILabel`)
- `tableViewList` (type: `UITableView`)
- `primaryButton`  (type: ``RoundedButton`` inherits from ``SecondaryButton``)
- `secondaryButton`  (type: ``SecondaryButton`` inherits from ``UIButton``)
    
This screen provides an optional `bodyLabel` that could be used for instructional information below a `titleLabel` heading. There is a stack view below `BodyLabel` which allows you to place childs views for any information to show or functionalty, this is refered to `childView` in the view model. The main content of this screen is the table view (`UITableView`) which allows the user to submit selected information back to the site of the initialisation of the view model via a call-back closure with a `GDSLocalisedString` parameter, the table also has an optional `tableTitleLabel`.
There is a primary Call To Action (CTA) on this screen and an optional secondary CTA which is hidden by default, if the `secondaryButtonView` is not nil in the view model this button is shown. The navigation back button and right bar button are configurable.
If this screen should be presented as a modal view, this should be done at the call site:

```swift
  let navigationController = UINavigationController(rootViewController: vc)
  navigationController.modalPresentationStyle = .pageSheet
  root.present(navigationController, animated: true)
```

The content on the screen is set from the `viewModel`, which must conform to the ``ListOptionsViewModel`` protocol.


## ModalInfoView
This screen includes the following views:
- `titleLabel` (type: `UILabel`)
- `bodyLabel` (type: `UILabel`)
- `bodyTextColor` (type: `UIColor`)

This screen is typically used to present information in a modal context, consisting of a title to illustrate the nature of information and body to give sufficient detail.

The `titleLabel` and `bodyLabel` are within a `UIStackView`.
The content on the screen is set from the `viewModel`, which must conform to the `ModalInfoViewModel` protocol.

Additional protocols for this view are available to add configuration and subviews.
The `isModalInPresentation` property is a `Bool` and set from the `viewmodel`, which must conform to the `ModalInfoExtraViewModel` protocol. If the `viewmodel` does not conform to this protocol and provide this property, theis property will have default a value set.

The `primaryButton` and `secondaryButton` are `UIButton`s and placed within a `UIStackView`.
The configuration for these views are set from the `viewModel`, which must conform to the `PageWithPrimaryButtonViewModel` and `PageWithSecondaryButtonViewModel` protocols respectively. If the `viewmodel` does not conform to these protocols and provide these properties, the buttons will be hidden.


### GDSLoadingScreen
 This screen includes the following views:
 - `loadingLabel` (type: `UILabel`)

 This screen is typically used to as a loading screen for asynchronous tasks to inform the user and prevent interaction with the app UI.
 The screen features a large activity indicator and a title with text which is configurable and should be localised.


## IntroScreen
This screen includes the following views:
- `introImage` (type: `UIImageView`)
- `titleLabel` (type: `UILabel`)
- `bodyLabel` (type: `UILabel`)
- `introButton`  (type: ``RoundedButton`` inherits from `SecondaryButton`)

This screen is typically used as a introduction screen when a user opens an app. Consisting of an app icon, a title, a body and a button to initiate the first action in the app.

The `introImage`, `titleLabel` and `bodyLabel` are within a `UIScrollView`. The `introButton` is within a `UIStackView`.
The content on the screen is set from the `viewModel`, which must conform to the `IntroViewModel` protocol.

There is a single Call To Action (CTA) on this screen. The navigation back button and right bar button are configurable.
If this screen should be presented as a modal view, this should be done at the call site.


## DatePicker (iOS 13.4 and later)
This screen includes the following views:
- `titleLabel` (type: `UILabel`)
- `datePicker` (type: `UIDatePicker`)
- `footerLabel` (type: `UILabel`)
- `primaryButton` (type: ``RoundedButton`` inherits from `SecondaryButton`)

This screen provides an iOS `inline` Date Picker (for iOS 14 and later) below a 
heading instructions. For devices between iOS 13.4 until 14, it uses `automatic` 
style by default. This is configurable in the `DatePickerViewModel` using the
`pickerStyle` property.
The content on the screen is set from the `viewModel`, which must conform to the `DatePickerViewModel` protocol.


## TextInput
This screen includes the following views:
- `titleLabel` (type: `UILabel`)
- `textField` (type: `UITextField`)
- `textFieldFooter` (type: `UILabel`)
- `primaryButton`  (type: ``RoundedButton`` inherits from SecondaryButton)

This screen includes a title and a text field below with an optional footer below that. The data that is returned from the text field can be validated by the `validator` method on the `TextFieldViewModel` (a child property on the ViewModel) and the return type must conform to `LosslessStringConvertible`.

The content on the screen is set from the `viewModel`, which must conform to the `TextInputViewModel` protocol.


## IconScreen
This screen includes the following views:
- `imageView` (type: `UIImageView`)
- `titleLabel` (type: `UILabel`)
- `bodyLabel` (type: `UILabel`)

This screen includes an icon, title and body. These views a situated within a `UIStackView` where other subviews can be added through the `childViews` property in the view model.
The content on the screen is set from the `viewModel`, which must conform to the `IconScreenViewModel` protocol.


## OptionView
This screen includes the following views:
- `titleLabel` (type: `UILabel`)
- `subtitleLabel` (type: `UILabel`)
- `button` (type: ``SecondaryButton`` inherits from `UIButton`)

This screen includes an title, subtitle and button. These views a situated within a `UIStackView` which has margins set to align the subviews within it. This view is typically added as a subview to the `IconScreen` through the `IconScreen`s view model `childViews` property.
The content on the screen is set from the `viewModel`, which must conform to the `OptionViewModel` protocol.

## GDSError

This screen is typically used as an error screen, consisting of an alert icon, a title, body and the option of one, two or three buttons.
A `UIStackView` holds the `errorImageView` and encases a second `UIStackView` which holds the `errorTitle` and `errorBody`. These views are placed within a `ScrollView`.
The `primaryButton`, `secondaryButton` and `tertiaryButton` are placed in a `UIStackView`, below the `ScrollView`.

`GDSErrorViewController` inherits from `BaseViewController`, so a navigation back button and right bar button can be configured. If this screen should be presented as a modal view, this should be done at the call site.

A navigation item can be configured:
- The `primaryButton`'s action is set from the ``primaryButtonViewModel`` in the ``GDSErrorViewModel`` protocol.
- The `secondaryButton`'s action is set from the ``secondaryButtonViewModel`` in the ``GDSErrorViewModel`` protocol.
- The `tertiaryButton`'s action is set from the ``tertiaryButtonViewModel` in the ``GDSTertiaryButtonViewModel`` protocol.

If the viewModel conforms to BaseViewModel:
- A back button can be set via the `hideBackButton` boolean property on the view controller
- A right bar button can be set via the`rightBarButtonTitle` string property on the view controller
- A `viewWillAppear` lifecycle event triggers the `didAppear` method in the viewModel.
- A `dismissScreen` lifecycle event triggers the `didDismiss` method in the viewModel.

### Example:

```swift
struct MockErrorViewModel: GDSErrorViewModel, BaseViewModel {
    let image: String = "exclamationmark.circle"
    let title: GDSLocalisedString = "This is an Error View title"
    let body: GDSLocalisedString = "This is an Error View body This is an Error View body"
    let primaryButtonViewModel: ButtonViewModel 
    let secondaryButtonViewModel: ButtonViewModel? = nil
    let rightBarButtonTitle: GDSLocalisedString?
    let backButtonIsHidden: Bool = false
    
    init(action: @escaping () -> Void) {
        self.primaryButtonViewModel = ButtonViewModel(titleKey: "Try again") { 
            action() 
        } 
    }
    
    func didAppear() {}
    
    func didDismiss() {}
}
```

## GDSInformation

This screen is designed to present information to users, consisting of an image, title, (optional) body, (optional) footnote, primary button and an (optional) secondary button.

As part of the confirguation of the image, it has the following customisation: 
- `imageWeight` is used to determine the weight of the image (default: .semibold)
- `imageColour` (default: .gdsPrimary)
- `imageHeightConstraint` used to determine the images' height (default: 55)

To insure the height value supplied to `viewModel.imageHeightConstraint` is accurately displayed in the viewModel, an `imagePaddingCompensation` of 11 is added to the inputted value.

```swift
if let value = viewModel.imageHeightConstraint {
    heightConstraint = value + imagePaddingCompensation
} else {
    heightConstraint = defaultImageHeight
}
```

In `GDSInformationViewController` `footnote` is given a maximum content size, this is to stop the footnote covering the ScrollView when the devices' dynamic type is set to maximum.

```swift
if #available(iOS 15.0, *) {
    footnoteLabel.maximumContentSizeCategory = .accessibilityMedium
}
```

`GDSInformationViewController` inherits from `BaseViewController`, so a navigation back button and right bar button can be configured. If this screen should be presented as a modal view, this should be done at the call site.

### Example:

```swift
struct MockGDSInformationViewModel: GDSInformationViewModel, BaseViewModel {
    let image: String = "lock"
    let imageWeight: UIFont.Weight? = nil
    let imageColour: UIColor? = nil
    let imageHeightConstraint: CGFloat? = nil
    let title: GDSLocalisedString = "This is an Information View title"
    let body: GDSLocalisedString? = "This is an Information View body. \n\n This is another Information View body."
    let footnote: GDSLocalisedString? = "This is an Information View footnote where additional information for the buttons can be detailed."
    let primaryButtonViewModel: ButtonViewModel = MockButtonViewModel.primary
    let secondaryButtonViewModel: ButtonViewModel? = MockButtonViewModel.secondary
    let rightBarButtonTitle: GDSLocalisedString? = nil
    let backButtonIsHidden: Bool = false
    
    func didAppear() {}
    
    func didDismiss() {}
}
```

# Accessibility

## VoiceOverFocus
Conform view controllers that inherit from `BaseViewController` to `VoiceOverFocus` protocol to benefit from automatic setting of initial VoiceOver focus to a chosen `UIView` when the view controller appears.

Adding this conformance requires adding the following property to a view controller:

```swift
final class someViewController: BaseViewController, VoiceOverFocus {

...

    public var initialVoiceOverView: UIView {
        someUIView
    }
}
```

The view returned by this property will be set to be the intitial focus for VoiceOver when the view controller's `viewIsAppearing` lifecycle method is called during the presentation of the screen.
