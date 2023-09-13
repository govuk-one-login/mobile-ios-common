public protocol Event {
    var name: EventName { get }
    var text: String { get }
    var type: EventType { get }
    
    var parameters: [String: String] { get }
}
