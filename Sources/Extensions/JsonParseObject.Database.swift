
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
    
    func parseTitlePropertyWithoutLinks(columnName: String) throws -> String {
        let obj = try self.parseObject(name: columnName)
        let richTexts = try obj.parseArray(name: NotionNodes.title)
        var titleStr: String = ""
        var previousWasLink = false
        for richText in richTexts {
            let text = try richText.parseString(name: NotionNodes.plainText)
            if (isNil(name: NotionNodes.href)) {
                if (!(previousWasLink && text == " ")) {
                    titleStr = titleStr + text
                }
            }
            else {
                previousWasLink = true
            }
        }
        return titleStr
    }
    
    func parseTitleLinksDict(columnName: String) throws -> [String: String] {
        let obj = try self.parseObject(name: columnName)
        let richTexts = try obj.parseArray(name: NotionNodes.title)
        var dict: [String: String] = [:]
        for richText in richTexts {
            let text = try richText.parseString(name: NotionNodes.plainText)
            if (!isNil(name: NotionNodes.href)) {
                dict[text] = try richText.parseString(name: NotionNodes.href)
            }
        }
        return dict
    }
    
    func parseTitleLinks(columnName: String) throws -> [String] {
        let obj = try self.parseObject(name: columnName)
        let richTexts = try obj.parseArray(name: NotionNodes.title)
        var list: [String] = []
        for richText in richTexts {
            if (!isNil(name: NotionNodes.href)) {
                let href = try richText.parseString(name: NotionNodes.href)
                list.append(href)
            }
        }
        return list
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
    
    
    func parseTextPropertyWithoutLinks(columnName: String) throws -> String {
        let obj = try self.parseObject(name: columnName)
        let richTexts = try obj.parseArray(name: NotionNodes.richText)
        var titleStr: String = ""
        var previousWasLink = false
        for richText in richTexts {
            let text = try richText.parseString(name: NotionNodes.plainText)
            if (isNil(name: NotionNodes.href)) {
                if (!(previousWasLink && text == " ")) {
                    titleStr = titleStr + text
                }
            }
            else {
                previousWasLink = true
            }
        }
        return titleStr
    }
    
    func parseTextLinksDict(columnName: String) throws -> [String: String] {
        let obj = try self.parseObject(name: columnName)
        let richTexts = try obj.parseArray(name: NotionNodes.richText)
        var dict: [String: String] = [:]
        for richText in richTexts {
            let text = try richText.parseString(name: NotionNodes.plainText)
            if (!isNil(name: NotionNodes.href)) {
                dict[text] = try richText.parseString(name: NotionNodes.href)
            }
        }
        return dict
    }
    
    func parseTextLinks(columnName: String) throws -> [String] {
        let obj = try self.parseObject(name: columnName)
        let richTexts = try obj.parseArray(name: NotionNodes.richText)
        var list: [String] = []
        for richText in richTexts {
            if (!isNil(name: NotionNodes.href)) {
                let href = try richText.parseString(name: NotionNodes.href)
                list.append(href)
            }
        }
        return list
    }
    
    func parseIntProperty(columnName: String, canBeNil: Bool = true) throws -> Int? {
        let obj = try self.parseObject(name: columnName)
        if (canBeNil) {
            if (obj.isNil(name: NotionNodes.number)) {
                return nil
            }
        }
        let number = try obj.parseInt(name: NotionNodes.number)
        return number
    }
    
    func parseDoubleProperty(columnName: String, canBeNil: Bool = true) throws -> Double? {
        let obj = try self.parseObject(name: columnName)
        if (canBeNil) {
            if (obj.isNil(name: NotionNodes.number)) {
                return nil
            }
        }
        let number = try obj.parseDouble(name: NotionNodes.number)
        return number
    }
    
    func parseSelectProperty<E: RawRepresentable>(columnName: String, canBeNil: Bool = true) throws -> E? where E.RawValue == String {
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
    
    func parseMultiSelectProperty<E: RawRepresentable>(columnName: String, minimumLength: Int = 0, maximumLength: Int = Int.max) throws -> [E] where E.RawValue == String {
        let obj = try self.parseObject(name: columnName)
        let multiSelect = try obj.parseArray(name: NotionNodes.multiSelect, minCount: minimumLength, maxCount: maximumLength)
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
    
    func parseStartDateProperty(columnName: String, dateTime: Bool = false, canBeNil: Bool = true, timezone: TimeZone = TimeZone.current) throws -> Date? {
        let obj = try self.parseObject(name: columnName)
        if (canBeNil) {
            if (obj.isNil(name: NotionNodes.date)) {
                return nil
            }
        }
        let date = try obj.parseObject(name: NotionNodes.date)
        if (dateTime) {
            let start = try date.parseDateTime(name: NotionNodes.start, timezone: timezone)
            return start
        } else {
            let start = try date.parseDate(name: NotionNodes.start, timezone: timezone)
            return start
        }
    }
    
    func parseDateProperty(columnName: String, dateTime: Bool = false, canBeNil: Bool = true, timezone: TimeZone = TimeZone.current) throws -> (Date, Date)? {
        let obj = try self.parseObject(name: columnName)
        if (canBeNil) {
            if (obj.isNil(name: NotionNodes.date)) {
                return nil
            }
        }
        let date = try obj.parseObject(name: NotionNodes.date)
        if (canBeNil) {
            if (date.isNil(name: NotionNodes.end) || date.isNil(name: NotionNodes.start)) {
                return nil
            }
        }
        if (dateTime) {
            let start = try date.parseDateTime(name: NotionNodes.start, timezone: timezone)
            let end = try date.parseDateTime(name: NotionNodes.end, timezone: timezone)
            return (start, end)
        } else {
            let start = try date.parseDate(name: NotionNodes.start, timezone: timezone)
            let end = try date.parseDate(name: NotionNodes.end, timezone: timezone)
            return (start, end)
        }
    }
    
    func parsePersonProperty(columnName: String, minimumLength: Int = 0, maximumLength: Int = Int.max) throws -> [UUID] {
        let obj = try self.parseObject(name: columnName)
        let peoples = try obj.parseArray(name: NotionNodes.people, minCount: minimumLength, maxCount: maximumLength)
        var ids: [UUID] = []
        for people in peoples {
            let id = try people.parseUUID(name: NotionNodes.id)
            ids.append(id)
        }
        return ids
    }
    
    func parseCheckboxProperty(columnName: String) throws -> Bool {
        let obj = try self.parseObject(name: columnName)
        let res = try obj.parseBool(name: NotionNodes.checkbox)
        return res
    }
    
    func parseUrlProperty(columnName: String, canBeNil: Bool = true) throws -> String? {
        let obj = try self.parseObject(name: columnName)
        if (canBeNil) {
            if (obj.isNil(name: NotionNodes.url)) {
                return nil
            }
        }
        let res = try obj.parseString(name: NotionNodes.url)
        return res
    }
    
    func parseEmailProperty(columnName: String, canBeNil: Bool = true) throws -> String? {
        let obj = try self.parseObject(name: columnName)
        if (canBeNil) {
            if (obj.isNil(name: NotionNodes.email)) {
                return nil
            }
        }
        let res = try obj.parseString(name: NotionNodes.email)
        return res
    }
    
    func parsePhoneProperty(columnName: String, canBeNil: Bool = true) throws -> String? {
        let obj = try self.parseObject(name: columnName)
        if (canBeNil) {
            if (obj.isNil(name: NotionNodes.phone)) {
                return nil
            }
        }
        let res = try obj.parseString(name: NotionNodes.phone)
        return res
    }
    
    func parseFilesProperty(columnName: String, minimumLength: Int = 0, maximumLength: Int = Int.max) throws -> [String] {
        let obj = try self.parseObject(name: columnName)
        var list: [String] = []
        let files = try obj.parseArray(name: NotionNodes.files, minCount: minimumLength, maxCount: maximumLength)
        for file in files {
            if (file.hasProperty(name: NotionNodes.file)) {
                let fileObj = try file.parseObject(name: NotionNodes.file)
                let url = try fileObj.parseString(name: NotionNodes.url)
                list.append(url)
            } else if (file.hasProperty(name: NotionNodes.external)) {
                let fileObj = try file.parseObject(name: NotionNodes.external)
                let url = try fileObj.parseString(name: NotionNodes.url)
                list.append(url)
            } else {
                throw NotionSerializationError.missing(file.path.joined(separator: ".") + " not implemented file")
            }
        }
        return list
    }
    
    func parseRelationsProperty(columnName: String, minimumLength: Int = 0, maximumLength: Int = Int.max) throws -> [String] {
        let obj = try self.parseObject(name: columnName)
        let relations = try obj.parseArray(name: NotionNodes.relation, minCount: minimumLength, maxCount: maximumLength)
        var list: [String] = []
        for relation in relations {
            let id = try relation.parseString(name: NotionNodes.id).replacingOccurrences(of: "-", with: "")
            list.append(id)
        }
        return list
    }
    
    func parseRollupIntProperty(columnName: String, canBeNil: Bool = true) throws -> Int? {
        let obj = try self.parseObject(name: columnName)
        let rollup = try obj.parseObject(name: NotionNodes.rollup)
        if (canBeNil) {
            if (rollup.isNil(name: NotionNodes.number)) {
                return nil
            }
        }
        let number = try rollup.parseInt(name: NotionNodes.number)
        return number
    }
    
    func parseRollupStartDateProperty(columnName: String, dateTime: Bool = false, canBeNil: Bool = true, timezone: TimeZone = TimeZone.current) throws -> Date? {
        let obj = try self.parseObject(name: columnName)
        let rollup = try obj.parseObject(name: NotionNodes.rollup)
        if (canBeNil) {
            if (rollup.isNil(name: NotionNodes.date)) {
                return nil
            }
        }
        let date = try rollup.parseObject(name: NotionNodes.date)
        if (dateTime) {
            let start = try date.parseDateTime(name: NotionNodes.start, timezone: timezone)
            return start
        } else {
            let start = try date.parseDate(name: NotionNodes.start, timezone: timezone)
            return start
        }
    }
    
//    func parseRollupIntArrayProperty(columnName: String, minimumLength: Int = 0, maximumLengrh: Int = Int.max) throws -> [Int] {
//        var list:[Int] = []
//        let obj = try self.parseObject(name: columnName)
//        let rollup = try obj.parseObject(name: NotionNodes.rollup)
//        let array = try rollup.parseArray(name: NotionNodes.array, minCount: minimumLength, maxCount: maximumLengrh)
//        for item in array {
//            let num = try item.parseInt(name: NotionNodes.number)
//            list.append(num)
//        }
//        return list
//    }
//
//    func parseRollupDoubleArrayProperty(columnName: String, minimumLength: Int = 0, maximumLengrh: Int = Int.max) throws -> [Double] {
//        var list:[Double] = []
//        let obj = try self.parseObject(name: columnName)
//        let rollup = try obj.parseObject(name: NotionNodes.rollup)
//        let array = try rollup.parseArray(name: NotionNodes.array, minCount: minimumLength, maxCount: maximumLengrh)
//        for item in array {
//            let num = try item.parseDouble(name: NotionNodes.number)
//            list.append(num)
//        }
//        return list
//    }
    
    
//
//    func parseRollupDoubleProperty(columnName: String, canBeNil: Bool = true) throws -> Double? {
//        let obj = try self.parseObject(name: columnName)
//        let rollup = try obj.parseObject(name: NotionNodes.rollup)
//        if (canBeNil) {
//            if (rollup.isNil(name: NotionNodes.number)) {
//                return nil
//            }
//        }
//        let number = try rollup.parseDouble(name: NotionNodes.number)
//        return number
//    }
    
//    func parseRollupCheckboxArrayProperty(columnName: String, minimumLength: Int = 0, maximumLengrh: Int = Int.max) throws -> [Bool] {
//        var list:[Bool] = []
//        let obj = try self.parseObject(name: columnName)
//        let rollup = try obj.parseObject(name: NotionNodes.rollup)
//        let array = try rollup.parseArray(name: NotionNodes.array, minCount: minimumLength, maxCount: maximumLengrh)
//        for item in array {
//            let check = try item.parseBool(name: NotionNodes.checkbox)
//            list.append(check)
//        }
//        return list
//    }
    
//    func parseRollupTextArrayProperty(columnName: String, minimumLength: Int = 0, maximumLengrh: Int = Int.max) throws -> [String] {
//        var list:[String] = []
//        let obj = try self.parseObject(name: columnName)
//        let rollup = try obj.parseObject(name: NotionNodes.rollup)
//        let array = try rollup.parseArray(name: NotionNodes.array, minCount: minimumLength, maxCount: maximumLengrh)
//        for item in array {
//            let richTexts = try item.parseArray(name: NotionNodes.richText)
//            var titleStr: String = ""
//            for richText in richTexts {
//                let text = try richText.parseString(name: NotionNodes.plainText)
//                titleStr = titleStr + text
//            }
//            list.append(titleStr)
//        }
//        return list
//    }
    
//    func parseRollupDateProperty(columnName: String, canBeNil: Bool = true, timezone: TimeZone = TimeZone.current) throws -> (Date, Date)? {
//        let obj = try self.parseObject(name: columnName)
//        let rollup = try obj.parseObject(name: NotionNodes.rollup)
//        if (canBeNil) {
//            if (rollup.isNil(name: NotionNodes.date)) {
//                return nil
//            }
//        }
//        let date = try rollup.parseObject(name: NotionNodes.date)
//        if (canBeNil) {
//            if (date.isNil(name: NotionNodes.end) || date.isNil(name: NotionNodes.start)) {
//                return nil
//            }
//        }
//        let start = try date.parseDateTime(name: NotionNodes.start, timezone: timezone)
//        let end = try date.parseDateTime(name: NotionNodes.end, timezone: timezone)
//        return (start, end)
//    }
    
    func parseFormulaIntProperty(columnName: String) throws -> Int {
        let obj = try self.parseObject(name: columnName)
        let formula = try obj.parseObject(name: NotionNodes.formula)
        let number = try formula.parseInt(name: NotionNodes.number)
        return number
    }
    
    func parseFormulaDoubleProperty(columnName: String) throws -> Double {
        let obj = try self.parseObject(name: columnName)
        let formula = try obj.parseObject(name: NotionNodes.formula)
        let number = try formula.parseDouble(name: NotionNodes.number)
        return number
    }
    
    func parseFormulaCheckboxProperty(columnName: String) throws -> Bool {
        let obj = try self.parseObject(name: columnName)
        let formula = try obj.parseObject(name: NotionNodes.formula)
        let res = try formula.parseBool(name: NotionNodes.boolean)
        return res
    }
    
    func parseFormulaStartDateProperty(columnName: String, timezone: TimeZone = TimeZone.current) throws -> Date {
        let obj = try self.parseObject(name: columnName)
        let formula = try obj.parseObject(name: NotionNodes.formula)
        let date = try formula.parseObject(name: NotionNodes.date)
        let start = try date.parseDateTime(name: NotionNodes.start, timezone: timezone)
        return start
    }
    
    func parseFormulaTextProperty(columnName: String) throws -> String {
        let obj = try self.parseObject(name: columnName)
        let formula = try obj.parseObject(name: NotionNodes.formula)
        let text = try formula.parseString(name: NotionNodes.string)
        return text
    }
}
