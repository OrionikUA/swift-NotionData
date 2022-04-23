
import Foundation

public struct PatchPropertyModel<T: Encodable>: Encodable {
    public let value: T
}
