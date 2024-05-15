# Utilities

Contains utility classes and functions that includes helper functions for date formatting, string manipulation, network requests etc. 

## GDSLocalisedString
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

## URLOpener
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

# Extensions

## EdgeInsets
Used to define spacing for elements on the screen, by adding values to top, bottom, left and right. For example, the `linkButton` has 0px (CGFloat) padding from the left. 
```swift
linkButton.titleEdgeInsets.left = 0
```

## UIFont
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

## popToNewViewController
Allows you to add a new viewController with a pop animation from the `root` which is the bottom of the navigation stack. 
```swift
root.popToNewViewController(vc, animated: true)
```

## StackView
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

## TableView
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

## View
Adds a child view to the parent view which can be customised by `edgeInset`.
An example usage is the `overlayView` (child) on the `cameraView` (parent) with no additional spacing.
```swift
        cameraView.addSubview(overlayView, insetBy: .zero)
```

## Image
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

## Text
Formats the alignment, size and font of the `title`, `subtitle` and `body` text based on Apple's system. 
For `Text` (this is a SwiftUI view type) we have:

- `title` (title alignment can be set as an optional parameter, it defaults to centre aligned)
- `subtitle`
- `bodyCentreAligned`
- `bodyHeader`
- `calloutBold`

## NSAttributedStrings
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

### addingSymbol
Used for adding SF Symbols to button labels. Can be positioned before or after the main string.

### addingAttributes
Used to add attributes to specific sections of an `NSAttributedString`. It is used by providing the main `String` and the `text` that attributes are to be applied to. For example, if there's a specific name within the main `String` that needs to be styled with bold text, you would pass in the name into the `text` parameter.

### overload of +
This allows the use of `+` for joining two `NSAttributedStrings`

### Convenience initialisers
The included convenience initialisers enable the initialisation of localised `NSAttributedString` with `LocalizableStrings` keys as they would be with `NSLocalizedString`.

The resulting string is an `NSAttributedString` which means that additional formatting can be applied.

## formatDate
Receives the date in the format of "yyMMdd" and re-formats it like this "dd-MMM-yy" as a String e.g. 07-SEP-23.
```swift
chipScanResult.dateOfBirth.formatDate()
```

## UInt64
The `twoSeconds` method used as a wait.
```swift
try await Task.sleep(nanoseconds: .twoSeconds)
```

