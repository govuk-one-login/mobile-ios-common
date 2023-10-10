import Foundation

extension Date {
    func shiftedBy(days: Int) -> Date? {
        Calendar.current.date(byAdding: .day, value: days, to: self, wrappingComponents: false)
    }
}
