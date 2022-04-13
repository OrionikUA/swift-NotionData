import Foundation

public extension JsonParseObject {
    func parseResults() throws -> [JsonParseObject] {
        let results = try self.parseArray(name: NotionNodes.results)
        return results
    }
    
    func tryParseError() -> NotionResponseErrorModel? {
        do {
            let object = try self.parseString(name: NotionNodes.object)
            let status = try self.parseInt(name: NotionNodes.status)
            let code = try self.parseString(name: NotionNodes.code)
            let message = try self.parseString(name: NotionNodes.message)
            return NotionResponseErrorModel(object: object, status: status, code: code, message: message)
        } catch {
            return nil
        }
    }
}
