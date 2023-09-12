import UIKit

extension UIColor {
    
    /// Initializer that uses the colour asset catalog
    /// - Parameter color: takes the GDSColours enum and uses the raw value as the colour name within the colour asset catalog
    private convenience init(_ color: GDSColours) {
        self.init(named: color.rawValue, in: .module, compatibleWith: nil)!
    }
    
    /// Method used to get accent colour named `AccentColour` from the asset catalog of the `main` bundle. If `AccentColor` does not exist then `gdsGreen` is returned
    internal static var accent: UIColor {
        if let colour = UIColor(named: "AccentColor", in: .main, compatibleWith: nil) {
            return colour
        } else {
            return gdsGreen
        }
    }
    public static let gdsGreen = UIColor(.gdsGreen)
    public static let gdsDarkGreen = UIColor(.gdsDarkGreen)
    public static let gdsYellow = UIColor(.gdsYellow)
    public static let gdsGrey = UIColor(.gdsGrey)
    public static let gdsPrimary = UIColor(.gdsPrimary)
    public static let gdsLightGreen = UIColor(.gdsLightGreen)
    public static let gdsBlack = UIColor(.gdsBlack)
    public static let gdsBlue = UIColor(.gdsBlue)
    public static let gdsBrightPurple = UIColor(.gdsBrightPurple)
    public static let gdsBrown = UIColor(.gdsBrown)
    public static let gdsDarkBlue = UIColor(.gdsDarkBlue)
    public static let gdsDarkGrey = UIColor(.gdsDarkGrey)
    public static let gdsDarkRed = UIColor(.gdsDarkRed)
    public static let gdsLightBlue = UIColor(.gdsLightBlue)
    public static let gdsLightGrey = UIColor(.gdsLightGrey)
    public static let gdsLightPink = UIColor(.gdsLightPink)
    public static let gdsLightPurple = UIColor(.gdsLightPurple)
    public static let gdsMidGrey = UIColor(.gdsMidGrey)
    public static let gdsOrange = UIColor(.gdsOrange)
    public static let gdsPink = UIColor(.gdsPink)
    public static let gdsPurple = UIColor(.gdsPurple)
    public static let gdsTurquoise = UIColor(.gdsTurquoise)
    // TODO: DCMAW-6572 Review colours based on investigation from Design
    /// Internal method are used as `DialogBackground` and `DialogText` are not part of the GDS Design System and will be replaced and updated in the main repository in future
    internal static let dialogBackground = UIColor(.dialogBackground)
    internal static let dialogText = UIColor(.dialogText)
   
    /// Conforms to `CaseIterable` to allow a single test to iterate over all colours
    /// Enum for GDS Design System colours with raw type of `String` to allow type safe access to the asset catalog
    public enum GDSColours: String, CaseIterable {
        case gdsGreen = "Green"
        case gdsDarkGreen = "DarkGreen"
        case gdsYellow = "Yellow"
        case gdsGrey = "Grey"
        case gdsPrimary = "Primary"
        case gdsLightGreen = "LightGreen"
        case gdsBlack = "Black"
        case gdsBlue = "Blue"
        case gdsBrightPurple = "BrightPurple"
        case gdsBrown = "Brown"
        case gdsDarkBlue = "DarkBlue"
        case gdsDarkGrey = "DarkGrey"
        case gdsDarkRed = "DarkRed"
        case gdsLightBlue = "LightBlue"
        case gdsLightGrey = "LightGrey"
        case gdsLightPink = "LightPink"
        case gdsLightPurple = "LightPurple"
        case gdsMidGrey = "MidGrey"
        case gdsOrange = "Orange"
        case gdsPink = "Pink"
        case gdsPurple = "Purple"
        case gdsTurquoise = "Turquoise"
        // TODO: DCMAW-6572 Review colours based on investigation from Design
        case dialogBackground = "DialogBackground"
        case dialogText = "DialogText"
    }
}
