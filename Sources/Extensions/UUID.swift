import Foundation

extension UUID {
    var notionId: String {
        self.uuidString.replacingOccurrences(of: "-", with: "").lowercased()
    }
}
