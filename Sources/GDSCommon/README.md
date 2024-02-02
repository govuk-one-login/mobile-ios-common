# GDS Common

A set of UI components and patterns that implements the [GOV.UK Design System](https://design-system.service.gov.uk) for mobile. 
It also includes shared utility and helper functions used across our different apps including *GOV.UK ID Check*. It is used to promote code reusability, maintainability, a DRY (Don't Repeat Yourself) coding approach and ensures consistency across different UK Government applications and frameworks.

1. [Styles](#styles)
2. [Components](#components)
3. [Patterns](#patterns)
4. [Utilities](#utilities)
5. [Extensions](#extensions)

## Styles

Make government services look like GOV.UK with guides for applying colours and images.

We use default system fonts on mobile, rather than GDS Transport, to take full advantage of accessibility features provided by iOS. 

### Colours

All of the colours are available as an extension of `UIColor`.

```swift 
yourButton.setTitleColor(UIColor.gdsGreen, for: .normal)
```

#### gdsLightGreen
#### gdsBlack 
#### gdsBlue 
#### gdsBrightPurple 
#### gdsBrown 
#### gdsDarkBlue
#### gdsDarkGrey 
#### gdsDarkRed 
#### gdsLightBlue
#### gdsLightGrey 
#### gdsLightPink
#### gdsLightPurple
#### gdsMidGrey
#### gdsOrange
#### gdsPink 
#### gdsPurple 
#### gdsTurquoise 

The colours below has `gds` prefix to keep the naming convention consistent but does not match with the colours on GOV.UK Design System: 

#### gdsGreen
Updates the colour when dark mode is enabled
#### gdsDarkGreen
#### gdsYellow
#### gdsGrey
Updates the colour when dark mode is enabled
#### gdsPrimary
Updates the colour when dark mode is enabled

## Components

Save time with reusable, accessible components for buttons and dialog views.

### RoundedButton
Primary button for main actions, it's a green button (by default) with rounded corners and an optional icon. 

The colour of this button is determined by the `Accent` colour of your app. The button can be added via storyboard file or via the codebase.

### ButtonViewModel
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


#### SecondaryButton
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

### SymbolPosition
Sets up the image icon on either the left or right of the text within the button by using either `beforeTitle` or `afterTitle` enums. 
For example the symbol position is placed before the text within the `qrCodeButton`.
```swift 
qrCodeButton.symbolPosition = .beforeTitle
```

### DialogView
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

### BulletView
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

## Patterns

### BaseViewController

``BaseViewController`` inherits from `UIViewController`. ``BaseViewController`` includes the repetitive code that all screens should have to avoid repetition and reduce risk of missing important functionality and to make it easier to amend, or fix defects if they arise.

Screen view controllers should generally inherit from ``BaseViewController`` instead of `UIViewController` unless the functionality of the screen needs to be intentionally different from standard screens.

#### To use:

Once inheriting from ``BaseViewController`` and adding conformance to ``BaseViewModel`` to concrete view model, in the future do not add the following properties and methods to view model protocols:

```swift
var rightBarButtonTitle: GDSLocalisedString? { get }
var backButtonIsHidden: Bool { get }
func didAppear()
func didDismiss()
```
Instead, when creating concrete implementations of view models, conform the concrete implementations to the view model protocol _and_ to the ``BaseViewModel`` protocol. ``BaseViewModel`` includes the above properties and methods.

As long as the view controller inherits from ``BaseViewController`` instead of `UIViewController`, these will be handled without any additional code.

#### Example

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

### GDSInstructions
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


### Instruction Screen With Image
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


### PopoverTableViewController

``PopoverTableViewController`` inherits from `UIViewController`. This allows showing a list, as a popover giving the user multiple options from one button. To use this the view controller will need to conform to `UIPopoverPresentationControllerDelegate`.

This screen includes the following views:
- `tableView` (type: `UITableView`)

The content on the screen is set from the `viewModel`, which must conform to the `PopoverItemViewModel` protocol.

#### Example

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


### ListOptions
This screen includes the following views:
- `titleLabel` (type: `UILabel`)
- `bodyLabel` (type: `UILabel`?)
- `footerLabel` (type: `UILabel`?)
- `tableViewList` (type: `UITableView`)
- `primaryButton`  (type: ``RoundedButton`` inherits from ``SecondaryButton``)
    
This screen provides an optional `bodyLabel` that could be used for instructional information below a `titleLabel` heading. The main content of this screen is the table view (`UITableView`) which allows the user to submit selected information back to the site of the initialisation of the view model via a call-back closure with a `GDSLocalisedString` parameter.
There is a single Call To Action (CTA) on this screen. The navigation back button and right bar button are configurable.
If this screen should be presented as a modal view, this should be done at the call site:

```swift
  let navigationController = UINavigationController(rootViewController: vc)
  navigationController.modalPresentationStyle = .pageSheet
  root.present(navigationController, animated: true)
```

The content on the screen is set from the `viewModel`, which must conform to the ``ListOptionsViewModel`` protocol.


### ModalInfoView
This screen includes the following views:
- `titleLabel` (type: `UILabel`)
- `bodyLabel` (type: `UILabel`)

This screen is typically used to present information in a modal context, consisting of a title to illustrate the nature of information and body to give sufficient detail.

The `titleLabel` and `bodyLabel` are within a `UIStackView`.
The content on the screen is set from the `viewModel`, which must conform to the `ModalInfoViewModel` protocol.


### IntroScreen
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


### DatePicker (iOS 13.4 and later)
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


### TextInput
This screen includes the following views:
- `titleLabel` (type: `UILabel`)
- `textField` (type: `UITextField`)
- `textFieldFooter` (type: `UILabel`)
- `primaryButton`  (type: ``RoundedButton`` inherits from SecondaryButton)

This screen includes a title and a text field below with an optional footer below that. The data that is returned from the text field can be validated by the `validator` method on the `TextFieldViewModel` (a child property on the ViewModel) and the return type must conform to `LosslessStringConvertible`.

The content on the screen is set from the `viewModel`, which must conform to the `TextInputViewModel` protocol.


### IconScreen
This screen includes the following views:
- `imageView` (type: `UIImageView`)
- `titleLabel` (type: `UILabel`)
- `bodyLabel` (type: `UILabel`)

This screen includes an icon, title and body. These views a situated within a `UIStackView` where other subviews can be added through the `childViews` property in the view model.
The content on the screen is set from the `viewModel`, which must conform to the `IconScreenViewModel` protocol.


### OptionView
This screen includes the following views:
- `titleLabel` (type: `UILabel`)
- `subtitleLabel` (type: `UILabel`)
- `button` (type: ``SecondaryButton`` inherits from `UIButton`)

This screen includes an title, subtitle and button. These views a situated within a `UIStackView` which has margins set to align the subviews within it. This view is typically added as a subview to the `IconScreen` through the `IconScreen`s view model `childViews` property.
The content on the screen is set from the `viewModel`, which must conform to the `OptionViewModel` protocol.

### GDSError

This screen is typically used as an error screen, consisting of an alert icon, a title, body and the option of one or two buttons.
A `UIStackView` holds the `errorImageView` and encases a second `UIStackView` which holds the `errorTitle` and `errorBody`. These views are placed within a `ScrollView`.
The `primaryButton` and `secondaryButton` are placed in a `UIStackView`, below the `ScrollView`.

`GDSErrorViewController` inherits from `BaseViewController`, so a navigation back button and right bar button can be configured. If this screen should be presented as a modal view, this should be done at the call site.

A navigation item can be configured:
- The `primaryButton`'s action is set from the ``primaryButtonViewModel`` in the viewModel.
- The `secondaryButton`'s action is set from the ``secondaryButtonViewModel`` in the viewModel.

If the viewModel conforms to BaseViewModel:
- A back button can be set via the `hideBackButton` boolean property on the view controller
- A right bar button can be set via the`rightBarButtonTitle` string property on the view controller
- A `viewWillAppear` lifecycle event triggers the `didAppear` method in the viewModel.
- A `dismissScreen` lifecycle event triggers the `didDismiss` method in the viewModel.

#### Example:

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

### GDSInformation

This screen is designed to present information to users, consisting of an image, title, (optional) body, (optional) footnote, primary button and an (optional) secondary button.

As part of the confirguation of the image, it has the following customisation: 
- `imageWeight` is used to determine the weight of the image (default: .semibold)
- `imageColour` (default: .gdsPrimary)
- `imageHeightConstraint` used to determine the images' height (default: 55)

In `GDSInformationViewController` `footnote` is given a maximum content size, this is to stop the footnote covering the ScrollView when the devices' dynamic type is set to maximum.

```swift
if #available(iOS 15.0, *) {
    footnoteLabel.maximumContentSizeCategory = .accessibilityMedium
}
```

`GDSInformationViewController` inherits from `BaseViewController`, so a navigation back button and right bar button can be configured. If this screen should be presented as a modal view, this should be done at the call site.

#### Example:

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

## Accessibility
### VoiceOverFocus
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

## Utilities

Contains utility classes and functions that includes helper functions for date formatting, string manipulation, network requests etc. 

### GDSLocalisedString
`GDSLocalisedString` is a custom type to help managing localisation. It has four stored properties and three computed properties:
- public let stringKey: `String`
- public let variableKeys: `[String]`
- let bundle: Bundle
- computed property: public var value: `String`
- computed property: public var description: `String` (equal to value)
- computed property: public var attributedValue: `NSAttributedString`
- private let attributes: `Attributes` (type alias)

Conforms to:

- `ExpressibleByStringLiteral`
- `CustomStringConvertible`

The stored property `attributes` is of type `Attributes` which is a `typealias` defined as `[(String, [NSAttributedString.Key: Any])]`.
  
The computed property `attributedValue` returns nil if the `GDSLocalisedString` has not been initialised with attributes. Otherwise, if attributes have been defined in the initialiser it will return an `NSAttributedString`.

The computed property `value` takes the `stringKey`, `variableKeys`, `bundle` and then uses `NSLocalizedString` to fetch the correct String for the language currently set in the app.

There are situations, such as analytics / logging, where it may be desirable to log a a consistent language regardless of the language preference set by the user. By retaining access to the `stringKey` and `variableKeys` when `GDSLocalisedString` is used, allows developers this flexibility.

This function is used in both `ButtonViewModel` and `UIViewModel` to retrieve the specific String value from keys.
```swift
struct AppUnavailableErrorViewModel: ErrorViewModel {
    let title = GDSLocalisedString(stringKey: "appUnavailableTitle", "appName")
```

### URLOpener
A protocol with an `open` method to perform the action of opening a URL. This is used on buttons that has an external link outside the application. 
We extend `UIApplication` and conform it to `URLOpener` protocol and implement the `open` method, doing this allows the mocking of URLOpener for testing purposes.
An example shown is when `didSessionStartOnThisDevice` is returned true the user is redirected to the abort url with the relevant parameters.
```swift
private func performWebHandback() {
    if !sessionService.didSessionStartOnThisDevice {
        showAdvice(submissionCoordinator: self)
        } else {
                urlOpener.open(url: .redirectSession(withID: sessionService.authSessionID))
                    finish(didAbortSession: true)
}
```

## Extensions

### EdgeInsets
Used to define spacing for elements on the screen, by adding values to top, bottom, left and right. For example, the `linkButton` has 0px (CGFloat) padding from the left. 
```swift
linkButton.titleEdgeInsets.left = 0
```

### UIFont
This extension includes a series of static properties defining [UIFont](https://developer.apple.com/design/human-interface-guidelines/typography/#Using-system-fonts) that align with Apple HIG names and styles, using the system font. There are two additional properties for specific other uses.
```swift
- footnote
- body
- bodyBold
- title3
- title3Bold
- title1
- title1Bold
- largeTitle
- largeTitleBold

- bulletFont (for the bullet points on `BulletView`)
- linkArrowFont (for the icon used when used on `SecondaryButton`)
```

The static properties can be used like this:
```swift
titleLabel.font = .largeTitleBold
```

### popToNewViewController
Allows you to add a new viewController with a pop animation from the `root` which is the bottom of the navigation stack. 
```swift
root.popToNewViewController(vc, animated: true)
```

### StackView
The `UIStackView` extension includes a convenience initialiser which is variadic, accepting any number of `UIView` and defaulting the other `UIStackView` arguments as follows:

- `axis` = `vertical`
- `spacing` = `24`
- `alignment` = `leading`

An example use:
```swift
// default use:
let stackView1 = UIStackView(views: label1, button, label2)

// adjusting some default arguments:
let stackView2 = UIStackView(views: stackView1, image, axis: .horizontal, spacing: 16)
```

### TableView
Displays data in a table and returns the table view managed by the controller object.
The extension on `UITableView` simplifies updating the table when content updates or a screen appears by adding a `redraw` method.
In the `UIViewController` where the `UITableView` is implemented can be used like this:

```swift
override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tableView.redraw()
}

override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    tableView.redraw()
}

func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    // `redraw` gets called when `viewWillLayoutSubviews` is called (see above)
    viewWillLayoutSubviews()
}
```

### View
Adds a child view to the parent view which can be customised by `edgeInset`.
An example usage is the `overlayView` (child) on the `cameraView` (parent) with no additional spacing.
```swift
        cameraView.addSubview(overlayView, insetBy: .zero)
```

### Image
To ensure icons are styled consistently there is a view modifier extension on `Image`. The `iconImage` modifier has optional arguments that allow adjusting the `size`, `colour` and `weight`. The defaults for these are as follows: 
- `size` = `100`
- `colour` = `nil`
- `weight` = `.light`

```swift
Image(systemName: viewModel.imageName)
    .iconImage()
```

The `iconImage` modifier includes the following modifiers:
``` swift
.resizable()
.scaledToFit()
.frame(maxWidth: size)
.imageScale(.large)
.accessibilityHidden(true)
.font(Font.body.weight(weight))
.foregroundColor(colour)
```

### Text
Formats the alignment, size and font of the `title`, `subtitle` and `body` text based on Apple's system. 
For `Text` (this is a SwiftUI view type) we have:

- `title` (title alignment can be set as an optional parameter, it defaults to centre aligned)
- `subtitle`
- `bodyCentreAligned`
- `bodyHeader`
- `calloutBold`

### NSAttributedStrings
A string with associated attributes (such as visual style, hyperlinks, or accessibility data) for portions of its text. 
The convenience initialiser calls `NSLocalisedString` when creating an `NSAttributedString` which makes it easier to use and deal with localisation. 
```swift
extension NSAttributedString {
    public convenience init(stringKey: String, _ parameters: CVarArg...) {
        let localisedString = String(format: NSLocalizedString(key: stringKey),
                                     arguments: parameters)
        self.init(string: localisedString)
    }
}
```

The included methods in the `NSAttributedStrings` extension are:

#### addingSymbol
Used for adding SF Symbols to button labels. Can be positioned before or after the main string.

#### addingAttributes
Used to add attributes to specific sections of an `NSAttributedString`. It is used by providing the main `String` and the `text` that attributes are to be applied to. For example, if there's a specific name within the main `String` that needs to be styled with bold text, you would pass in the name into the `text` parameter.

#### overload of +
This allows the use of `+` for joining two `NSAttributedStrings`

#### Convenience initialisers
The included convenience initialisers enable the initialisation of localised `NSAttributedString` with `LocalizableStrings` keys as they would be with `NSLocalizedString`.

The resulting string is an `NSAttributedString` which means that additional formatting can be applied.

### formatDate
Receives the date in the format of "yyMMdd" and re-formats it like this "dd-MMM-yy" as a String e.g. 07-SEP-23.
```swift
chipScanResult.dateOfBirth.formatDate()
```

### UInt64
The `twoSeconds` method used as a wait.
```swift
try await Task.sleep(nanoseconds: .twoSeconds)
```

