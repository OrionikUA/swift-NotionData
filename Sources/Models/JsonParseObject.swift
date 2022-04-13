import Foundation

public struct JsonParseObject {
    public let obj: [String: Any]
    public let path: [String]
    
    public init(obj: [String: Any], path: [String]) {
        self.obj = obj
        self.path = path
    }
    
    public init(_ data: Any) throws {
        let name = "root"
        guard let root = data as? [String: Any] else {
            throw NotionSerializationError.missing(name)
        }
        self.init(obj: root, path: [name])
    }
}
