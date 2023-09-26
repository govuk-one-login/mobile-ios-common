public protocol WelcomeViewModel {
    var title: GDSLocalisedString { get }
    var body: GDSLocalisedString { get }
    var welcomeButtonViewModel: ButtonViewModel { get }
    
    func didAppear()
}
