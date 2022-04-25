import Foundation

public class NotionBodyCreator {
    
    public static func createDatabaseRecordChange(changes: [NotionDatabaseColumnChange]) -> [String: Any] {
        var body: [String: Any] = [:]
        var changesList: [[String: Any]] = []
        for change in changes {
            changesList.append(createDatabaseColumnChange(change: change))
        }
        let properties = createProperties(dict: changesList)
        body.merge(properties) { (_, new) in new }
        return body
    }
    
    public static func createDatabaseRecordAdd(databaseId: String, changes: [NotionDatabaseColumnChange]) -> [String: Any] {
        var body: [String: Any] = [:]
        body.merge(NotionBodyCreator.createParentDatabaseValue(databaseId: databaseId)) { (_, new) in new }
        var changesList: [[String: Any]] = []
        for change in changes {
            changesList.append(createDatabaseColumnChange(change: change))
        }
        let properties = createProperties(dict: changesList)
        body.merge(properties) { (_, new) in new }
        return body
    }
    
    public static func createDatabaseColumnChange(change: NotionDatabaseColumnChange) -> [String: Any] {
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
        case .multiSelect:
            obj = createDatabaseMultiSelect(name: change.columnName, value: change.arrayStr)
        case .numberInt:
            obj = createDatabaseNumberInt(name: change.columnName, value: change.isNil ? nil : change.integer)
        case .numberDouble:
            obj = createDatabaseNumberDouble(name: change.columnName, value: change.isNil ? nil : change.double)
        case .startDate:
            obj = createDatabaseStartDate(name: change.columnName, value: change.isNil ? nil : change.text)
        case .relations:
            obj = createDatabaseReleations(name: change.columnName, value: change.arrayStr)
        }
        return obj
    }
    
    public static func createParentDatabaseValue(databaseId: String) -> [String: Any] {
        return ["parent": createDattabaseIdValue(id: databaseId)]
    }
    
    static func createDattabaseIdValue(id: String) -> [String: String] {
        return ["database_id": id]
    }
    
    public static func createProperties(dict: [[String: Any]]) -> [String: Any] {
        var tmp: [String: Any] = [:]
        for item in dict {
            tmp.merge(item) { (_, new) in new }
        }
        return ["properties": tmp]
    }
    
    public static func createDatabaseTitle(name: String, value: String) -> [String: Any] {
        return [name:
                    [
                        "title":
                            [
                                ["text": ["content": value]]
                            ]
                    ]
        ]
    }
    
    public static func createDatabaseText(name: String, value: String) -> [String: Any] {
        return [name:
                    [
                        "rich_text":
                            [
                                ["text": ["content": value]]
                            ]
                    ]
        ]
    }
    
    public static func createDatabaseMultiSelect(name: String, value: [String]) -> [String: Any] {
        let list = value.map({["name": $0]})
        return [name:
                    [
                        "multi_select": list
                    ]
        ]
    }
    
    public static func createDatabaseSelect(name: String, value: String) -> [String: Any] {
        return [name:
                    [
                        "select":
                            [
                                "name": value
                            ]
                    ]
        ]
    }
    
    public static func createDatabaseCheckbox(name: String, value: Bool) -> [String: Any] {
        return [name:
                    [
                        "checkbox": value
                    ]
        ]
    }
    
    public static func createDatabaseReleations(name: String, value: [String]) -> [String: Any] {
        let list = value.map({["id": $0]})
        return [name:
                    [
                        "relation": list
                    ]
        ]
    }
    
    public static func createDatabaseNumberInt(name: String, value: Int?) -> [String: Any] {
        return [name:
                    [
                        "number": value
                    ]
        ]
    }
    
    public static func createDatabaseNumberDouble(name: String, value: Double?) -> [String: Any] {
        return [name:
                    [
                        "number": value
                    ]
        ]
    }
    
    public static func createDatabaseStartDate(name: String, value: String?) -> [String: Any] {
        return [name:
                    [
                        "date": ["start": value]
                    ]
        ]
    }
    
    static func createFilter(filterContent: [String: Any]) -> [String: Any] {
        return ["filter": filterContent]
    }
    
    static func createAnd(query: [[String: Any]]) -> [String: Any] {
        return ["and": query]
    }
    
    static func createCheckbox(name: String, query: String, value: Bool) -> [String: Any] {
        return [ "property": name,
                 "checkbox":
                    [
                        query: value
                    ]
        ]
    }
    
    static func createTextPropertyFilter(name: String, type: String, query: String, text: String) -> [String: Any] {
        return [ "property": name,
                 type:
                    [
                        query: text
                    ]
        ]
    }
}
