import Foundation

public extension JsonParseObject {
    
    func isBlockType(type: String) throws -> Bool {
        try self.hasProperty(name: NotionNodes.id) && self.hasProperty(name: NotionNodes.type) && self.parseString(name: NotionNodes.type) == type
    }
    
    func getContainerBlockId() throws -> String? {
        if (!self.hasProperty(name: NotionNodes.id)) {
            return nil
        }
        
        for type in NotionContainerBlockType.allCases {
            if (self.hasProperty(name: type.rawValue)) {
                return try self.parseString(name: NotionNodes.id)
            }
        }
        
        return nil
    }
}

public extension Array where Element == JsonParseObject {
    func getContainerBlocksIds() throws -> [String] {
        var array: [String] = []
        
        for element in self {
            if let containerId = try element.getContainerBlockId() {
                array.append(containerId)
            }
        }
        return array
    }
    
    func filterByBlockType(type: String) throws -> [JsonParseObject] {
        var array = try self.filter({ try $0.isBlockType(type: type) })
        return array
    }
}
