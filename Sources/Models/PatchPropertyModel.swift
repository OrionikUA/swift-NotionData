
import Foundation

public struct PatchPropertyModel<T: Encodable>: Encodable {
    public let value: T
    
    public init(_ value: T) {
        self.value = value
    }
}
