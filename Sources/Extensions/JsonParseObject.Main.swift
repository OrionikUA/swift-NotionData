import Foundation

public extension JsonParseObject {
    func parseResults() throws -> [JsonParseObject] {
        let results = try self.parseArray(name: NotionNodes.results)
        return results
    }
}
