# GDS Common Utilities

A collection of utilities that are specific to GDS.

## GDS Analytics

A set of models that mirror the GDS Digital Identity Analytics Implementation Guide for Google Analytics. 

All data gathered via the Firebase SDK stream into the wider GDS Google Analytics account, therefore it is vital that all tracking aligns with the wider organisations approach and guidance.
These models ensure that all analytics submitted from the app are formed-correctly.

[Read More...](./Sources/GDSAnalytics/README.md)

## GDS Common

A set of UI components and patterns that implements the [GOV.UK Design System](https://design-system.service.gov.uk) for mobile. 

[Read More...](./Sources/GDSCommon/README.md)

## GDS Common - Demo

The demo project is set up to preview what reusable screen patterns are available to use and to enable more complete testing of the screens and components. 

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
