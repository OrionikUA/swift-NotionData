
import Foundation

struct PatchPropertyModel<T: Encodable>: Encodable {
    let value: T
}
