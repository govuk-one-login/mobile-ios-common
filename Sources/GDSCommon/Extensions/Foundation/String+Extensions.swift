import Foundation

extension String {
    public func formatDate() -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyMMdd"

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd.MMM.yy"

        guard let showDate = inputFormatter.date(from: self) else { return "-"}
        let resultString = outputFormatter.string(from: showDate)
        
        return resultString
    }
}
