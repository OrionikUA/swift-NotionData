import Foundation

public enum NotionClientError: Error {
    case creatingRequestError(description: String)
    case internalClientError(description: String)
    case internalClientSerializationError(description: String)
    case errorResponse(description: String)
    case jsonParserError(description: String)
}

extension NotionClientError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .creatingRequestError(description: let description): return description
        case .internalClientError(description: let description): return description
        case .internalClientSerializationError(description: let description): return description
        case .errorResponse(description: let description): return description
        case .jsonParserError(description: let description): return description
        }
    }
}
