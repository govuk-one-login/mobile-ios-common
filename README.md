# GDS Mobile Design System

Use this design system to make government apps consistent with GOV.UK.
Learn from the research and experience of other app teams, [GOV.UK Design System](https://design-system.service.gov.uk) and avoid repeating work that's already been done.

- Make services look and feel like GOV.UK using [styles](./Sources/GDSCommon/Styles/README.md).
- Use pre-built reusable [components](./Sources/GDSCommon/Components/README.md) to build consistent apps.
- [Patterns](./Sources/GDSCommon/Patterns/README.md) are best practice design solutions for specific user-focused tasks and pages.

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
