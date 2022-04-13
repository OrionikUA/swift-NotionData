
import Foundation

public extension JsonParseObject {
    func parsePageId() throws -> UUID {
        let obj = try self.parseUUID(name: NotionNodes.id)
        return obj
    }
    
    func parsePageProperties() throws -> JsonParseObject {
        let properties = try self.parseObject(name: NotionNodes.properties)
        return properties
    }
}
