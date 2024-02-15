import Foundation

public struct TaxonomyType {
    public enum FirstLevel: String {
        case oneLogin = "one login mobile application"
        case idCheck = "id check app"
    }
    
    public enum SecondLevel: String {
        case login = "login"
        case docChecking = "document checking application"
        case wallet = "wallet"
        case account = "account"
        case govUK = "govuk"
    }
    
    public enum ThirdLevel: String {
        case submitForm = "submit form"
        case passport = "passport cri"
        case drivingLicence = "driving licence cri"
        case brp = "brp cri"
        case manualLinking = "manual linking"
        case walletLibrary = "wallet library"
        case viewDocument = "view document"
        case addDocument = "add document"
        case manageAccount = "manage account"
        case deleteAccount = "delete account"
    }
}
