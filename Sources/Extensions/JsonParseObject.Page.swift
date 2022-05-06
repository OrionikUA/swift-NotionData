
import Foundation

public extension JsonParseObject {
    func parsePageId() throws -> UUID {
        let obj = try self.parseUUID(name: NotionNodes.id)
        return obj
    }
    
    func parsePageEmogi(canBeNil: Bool = true) throws -> String {
        if (canBeNil && (!self.hasProperty(name: NotionNodes.icon) || self.isNil(name: NotionNodes.icon))) {
            return ""
        }
        
        let icon = try self.parseObject(name: NotionNodes.icon)
        if (canBeNil && !icon.hasProperty(name: NotionNodes.emoji)) {
            return ""
        }
        let emoji = try icon.parseString(name: NotionNodes.emoji)
        return emoji
    }
    
    func parsePageProperties() throws -> JsonParseObject {
        let properties = try self.parseObject(name: NotionNodes.properties)
        return properties
    }
    
    func parsePageCreatedTime() throws -> Date {
        let date = try self.parseDateTime(name: NotionNodes.createdTime)
        return date
    }
    
    func parsePageLastEditedTime() throws -> Date {
        let date = try self.parseDateTime(name: NotionNodes.lastEditedTime)
        return date
    }
}
