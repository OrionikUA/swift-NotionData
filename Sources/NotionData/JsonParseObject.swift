import Foundation

public struct JsonParseObject {
    public let obj: [String: Any]
    let path: [String]
    
    public init(obj: [String: Any], path: [String]) {
        self.obj = obj
        self.path = path
    }
}
