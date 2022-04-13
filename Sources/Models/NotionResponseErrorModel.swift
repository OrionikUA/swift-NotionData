import Foundation

public struct NotionResponseErrorModel {
    public let object: String
    public let status: Int
    public let code: String
    public let message: String
    
    public var description: String {
        return String(status) + " " + code + ".\n" + message
    }
}
