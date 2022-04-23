import Foundation

class NotionBodyCreator {
    
    static func createDatabaseRecordChange(changes: [NotionDatabaseColumnChange]) -> [String: Any] {
        var body: [String: Any] = [:]
        var changesList: [[String: Any]] = []
        for change in changes {
            changesList.append(createDatabaseColumnChange(change: change))
        }
        let properties = createProperties(dict: changesList)
        body.merge(properties) { (_, new) in new }
        return body
    }
    
    static func createDatabaseColumnChange(change: NotionDatabaseColumnChange) -> [String: Any] {
        var obj:[String: Any]
        switch (change.columnType) {
        case .checkbox:
            obj = createDatabaseCheckbox(name: change.columnName, value: change.bool)
        case .title:
            obj = createDatabaseTitle(name: change.columnName, value: change.text)
        case .text:
            obj = createDatabaseText(name: change.columnName, value: change.text)
        case .select:
            obj = createDatabaseSelect(name: change.columnName, value: change.text)
        case .numberInt:
            obj = createDatabaseNumberInt(name: change.columnName, value: change.integer)
        case .numberDouble:
            obj = createDatabaseNumberDouble(name: change.columnName, value: change.double)
        case .startDate:
            obj = createDatabaseStartDate(name: change.columnName, value: change.isNil ? nil : change.text)
        }
        return obj
    }
    
    static func createParentDatabaseValue(databaseId: String) -> [String: Any] {
        return ["parent": createDattabaseIdValue(id: databaseId)]
    }
    
    static func createDattabaseIdValue(id: String) -> [String: String] {
        return ["database_id": id]
    }
    
    static func createProperties(dict: [[String: Any]]) -> [String: Any] {
        var tmp: [String: Any] = [:]
        for item in dict {
            tmp.merge(item) { (_, new) in new }
        }
        return ["properties": tmp]
    }
    
    static func createDatabaseTitle(name: String, value: String) -> [String: Any] {
        return [name:
                    [
                        "title":
                            [
                                ["text": ["content": value]]
                            ]
                    ]
        ]
    }
    
    static func createDatabaseText(name: String, value: String) -> [String: Any] {
        return [name:
                    [
                        "rich_text":
                            [
                                ["text": ["content": value]]
                            ]
                    ]
        ]
    }
    
    static func createDatabaseSelect(name: String, value: String) -> [String: Any] {
        return [name:
                    [
                        "select":
                            [
                                "name": value
                            ]
                    ]
        ]
    }
    
    static func createDatabaseCheckbox(name: String, value: Bool) -> [String: Any] {
        return [name:
                    [
                        "checkbox": value
                    ]
        ]
    }
    
    static func createDatabaseReleation(name: String, value: String) -> [String: Any] {
        return [name:
                    [
                        "relation":
                            [
                                ["id": value]
                            ]
                    ]
        ]
    }
    
    static func createDatabaseNumberInt(name: String, value: Int) -> [String: Any] {
        return [name:
                    [
                        "number": value
                    ]
        ]
    }
    
    static func createDatabaseNumberDouble(name: String, value: Double) -> [String: Any] {
        return [name:
                    [
                        "number": value
                    ]
        ]
    }
    
    static func createDatabaseStartDate(name: String, value: String?) -> [String: Any] {
        return [name:
                    [
                        "date": ["start": value]
                    ]
        ]
    }
}
