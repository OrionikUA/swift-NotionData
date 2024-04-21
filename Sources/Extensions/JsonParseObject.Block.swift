import Foundation

public extension JsonParseObject {
    
    func isBlockType(type: String) -> Bool {
        self.hasProperty(name: NotionNodes.id) && self.hasProperty(name: type)
    }
    
    func getContainerBlockId() throws -> String? {
        if (!self.hasProperty(name: NotionNodes.id)) {
            return nil
        }
        
        for type in NotionContainerBlockType.allCases {
            if (self.hasProperty(name: type.rawValue)) {
                return try self.parseString(name: type.rawValue)
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
        var array = self.filter({ $0.isBlockType(type: type) })
        return array
    }
}
