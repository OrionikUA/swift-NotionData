import Foundation

public struct NotionDatabaseColumnChange {
    public let columnType: NotionDatabaseColumnType
    public let columnName: String
    public let text: String
    public let integer: Int
    public let double: Double
    public let bool: Bool
    public let arrayStr: [String]
    public let isNil: Bool
    
    public init(columnType: NotionDatabaseColumnType, columnName: String, text: String = "", integer: Int = 0, double: Double = 0.0, bool: Bool = false, arrayStr: [String] = [], isNil: Bool = false)
    {
        self.columnType = columnType
        self.columnName = columnName
        self.text = text
        self.integer = integer
        self.double = double
        self.bool = bool
        self.arrayStr = arrayStr
        self.isNil = isNil
    }
    
    public static func createRelations(columnName: String, value: [String] = []) -> NotionDatabaseColumnChange {
        return NotionDatabaseColumnChange(columnType: NotionDatabaseColumnType.relations, columnName: columnName, arrayStr: value)
    }
    
    public static func createCheckbox(columnName: String, value: Bool) -> NotionDatabaseColumnChange {
        return NotionDatabaseColumnChange(columnType: NotionDatabaseColumnType.checkbox, columnName: columnName, bool: value)
    }
    
    public static func createTitle(columnName: String, value: String) -> NotionDatabaseColumnChange {
        return NotionDatabaseColumnChange(columnType: NotionDatabaseColumnType.title, columnName: columnName, text: value)
    }
    
    public static func createText(columnName: String, value: String) -> NotionDatabaseColumnChange {
        return NotionDatabaseColumnChange(columnType: NotionDatabaseColumnType.text, columnName: columnName, text: value)
    }
    
    public static func createSelect(columnName: String, value: String?) -> NotionDatabaseColumnChange {
        return NotionDatabaseColumnChange(columnType: NotionDatabaseColumnType.select, columnName: columnName, text: value != nil ? value! : "", isNil: value == nil)
    }
    
    public static func createMultiSelect(columnName: String, value: [String]) -> NotionDatabaseColumnChange {
        return NotionDatabaseColumnChange(columnType: NotionDatabaseColumnType.multiSelect, columnName: columnName, arrayStr: value)
    }
    
    public static func createInt(columnName: String, value: Int?) -> NotionDatabaseColumnChange {
        return NotionDatabaseColumnChange(columnType: NotionDatabaseColumnType.numberInt, columnName: columnName, integer: value != nil ? value! : 0, isNil: value == nil)
    }
    
    public static func createDouble(columnName: String, value: Double?) -> NotionDatabaseColumnChange {
        return NotionDatabaseColumnChange(columnType: NotionDatabaseColumnType.numberDouble, columnName: columnName, double: value != nil ? value! : 0, isNil: value == nil)
    }
    
    public static func createStartDate(columnName: String, value: String = "", isNil: Bool = false) -> NotionDatabaseColumnChange {
        return NotionDatabaseColumnChange(columnType: NotionDatabaseColumnType.startDate, columnName: columnName, text: value, isNil: isNil)
    }
}
