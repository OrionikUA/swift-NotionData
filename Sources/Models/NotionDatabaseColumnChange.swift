import Foundation

struct NotionDatabaseColumnChange {
    let columnType: NotionDatabaseColumnType
    let columnName: String
    let text: String
    let integer: Int
    let double: Double
    let bool: Bool
    let isNil: Bool
    
    init(columnType: NotionDatabaseColumnType, columnName: String, text: String = "", integer: Int = 0, double: Double = 0.0, bool: Bool = false, isNil: Bool = false)
    {
        self.columnType = columnType
        self.columnName = columnName
        self.text = text
        self.integer = integer
        self.double = double
        self.bool = bool
        self.isNil = isNil
    }
    
    static func createCheckbox(columnName: String, value: Bool) -> NotionDatabaseColumnChange {
        return NotionDatabaseColumnChange(columnType: NotionDatabaseColumnType.checkbox, columnName: columnName, bool: value)
    }
    
    static func createTitle(columnName: String, value: String) -> NotionDatabaseColumnChange {
        return NotionDatabaseColumnChange(columnType: NotionDatabaseColumnType.title, columnName: columnName, text: value)
    }
    
    static func createText(columnName: String, value: String) -> NotionDatabaseColumnChange {
        return NotionDatabaseColumnChange(columnType: NotionDatabaseColumnType.text, columnName: columnName, text: value)
    }
    
    static func createSelect(columnName: String, value: String) -> NotionDatabaseColumnChange {
        return NotionDatabaseColumnChange(columnType: NotionDatabaseColumnType.select, columnName: columnName, text: value)
    }
    
    static func createInt(columnName: String, value: Int) -> NotionDatabaseColumnChange {
        return NotionDatabaseColumnChange(columnType: NotionDatabaseColumnType.numberInt, columnName: columnName, integer: value)
    }
    
    static func createDouble(columnName: String, value: Double) -> NotionDatabaseColumnChange {
        return NotionDatabaseColumnChange(columnType: NotionDatabaseColumnType.numberDouble, columnName: columnName, double: value)
    }
    
    static func createStartDate(columnName: String, value: String = "", isNil: Bool = false) -> NotionDatabaseColumnChange {
        return NotionDatabaseColumnChange(columnType: NotionDatabaseColumnType.startDate, columnName: columnName, text: value, isNil: isNil)
    }
}
