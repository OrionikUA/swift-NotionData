
import Foundation

public extension JsonParseObject {
    func parseTitleProperty(columnName: String) throws -> String {
        let obj = try self.parseObject(name: columnName)
        let titles = try obj.parseArray(name: NotionNodes.title)
        var titleStr: String = ""
        for title in titles {
            let text = try title.parseString(name: NotionNodes.plainText)
            titleStr = titleStr + text
        }
        return titleStr
    }
    
    func parseTextProperty(columnName: String) throws -> String {
        let obj = try self.parseObject(name: columnName)
        let richTexts = try obj.parseArray(name: NotionNodes.richText)
        var titleStr: String = ""
        for richText in richTexts {
            let text = try richText.parseString(name: NotionNodes.plainText)
            titleStr = titleStr + text
        }
        return titleStr
    }
    
    func parseIntNumberProprty(columnName: String, canBeNil: Bool = true) throws -> Int? {
        let obj = try self.parseObject(name: columnName)
        if (canBeNil) {
            if (obj.isNil(name: NotionNodes.number)) {
                return nil
            }
        }
        let number = try obj.parseInt(name: NotionNodes.number)
        return number
    }
    
    func parseDoubleNumberProprty(columnName: String, canBeNil: Bool = true) throws -> Double? {
        let obj = try self.parseObject(name: columnName)
        if (canBeNil) {
            if (obj.isNil(name: NotionNodes.number)) {
                return nil
            }
        }
        let number = try obj.parseDouble(name: NotionNodes.number)
        return number
    }
    
    func parseSelectProprty<E: RawRepresentable>(columnName: String, canBeNil: Bool = true) throws -> E? where E.RawValue == String {
        let obj = try self.parseObject(name: columnName)
        if (canBeNil) {
            if (obj.isNil(name: NotionNodes.select)) {
                return nil
            }
        }
        let select = try obj.parseObject(name: NotionNodes.select)
        let name = try select.parseString(name: NotionNodes.name)
        guard let value = E(rawValue: name) else {
            let path = select.path + [NotionNodes.name] + [name]
            throw NotionSerializationError.missing(path.joined(separator: "."))
        }
        return value
    }
    
    func parseMultiSelect<E: RawRepresentable>(columnName: String, minimumLength: Int = 0) throws -> [E] where E.RawValue == String {
        let obj = try self.parseObject(name: columnName)
        let multiSelect = try obj.parseArray(name: NotionNodes.multiSelect, minCount: minimumLength)
        var list: [E] = []
        for item in multiSelect {
            let name = try item.parseString(name: NotionNodes.name)
            guard let value = E(rawValue: name) else {
                let path = item.path + [NotionNodes.name] + [name]
                throw NotionSerializationError.missing(path.joined(separator: "."))
            }
            list.append(value)
        }
        return list
    }
}
