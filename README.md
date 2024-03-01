# GDS Common Utilities

A collection of utilities that are specific to GDS.

## GDS Common

A set of UI components and patterns that implements the [GOV.UK Design System](https://design-system.service.gov.uk) for mobile. 

[Read More...](./Sources/GDSCommon/README.md)

## GDS Common - Demo

The demo project is set up to preview what reusable screen patterns are available to use and to enable more complete testing of the screens and components. 

To use the demo, make sure you open `GDSCommon-Demo.xcworkspace` file rather than the project or package file. To run the demo app please use `GDSCommon-Demo` scheme

When adding a new reusable screen pattern, the screen pattern should be added to the demo project. This can be done by adding a case to `Screens` enum as below. 

```swift
enum Screens: CaseIterable {
    case newScreen
    
    // Human readable name of the view you are presenting
    var name: String {
        switch self {
        case .newScreen:
            return "New Screen"
        }
    }
    
    // Is the view modal in presentation
    var isModal: Bool {
        switch self {
        case .newScreen:
            return false
        }
    }
    
    // Building the UIViewController to present the view
    var view: UIViewController {
        switch self {
        case .newScreen:
            let viewModel = NewScreenViewModel()
            let view = NewViewController(viewModel: viewModel)
            return view
        }
    }
}
```
