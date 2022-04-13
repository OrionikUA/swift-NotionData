import Foundation

public extension JsonParseObject {    
    func parseObject(name property: String) throws -> JsonParseObject {
        let path = self.path + [property]
        guard let obj = self.obj[property] as? [String: Any] else {
            throw NotionSerializationError.missing(path.joined(separator: "."))
        }
        return JsonParseObject(obj: obj, path: path)
    }
    
    func parseArray(name property: String, minCount: Int? = nil, maxCount: Int? = nil) throws -> [JsonParseObject] {
        let path = self.path + [property]
        guard let list = self.obj[property] as? [Any] else {
            throw NotionSerializationError.missing(path.joined(separator: "."))
        }
        var objList:[JsonParseObject] = []
        for (index, item)  in list.enumerated() {
            let arrayPath = path + [String(index)]
            guard let itemObj = item as? [String: Any] else {
                throw NotionSerializationError.missing(arrayPath.joined(separator: "."))
            }
            objList.append(JsonParseObject(obj: itemObj, path: arrayPath))
        }
        if let minCount = minCount {
            if (objList.count < minCount) {
                let lasIndexStr = "[" + String(minCount - 1) + "]"
                throw NotionSerializationError.missing(path.joined(separator: ".") + lasIndexStr)
            }
        }
        if let maxCount = maxCount {
            if (objList.count > maxCount) {
                let lasIndexStr = "[" + String(maxCount - 1) + "]"
                throw NotionSerializationError.missing(path.joined(separator: ".") + lasIndexStr)
            }
        }
        return objList;
    }
    
    func parseUUID(name property: String) throws -> UUID {
        let path = self.path + [property]
        guard let text = UUID(uuidString: self.obj[property] as? String ?? "nil") else {
            throw NotionSerializationError.missing(path.joined(separator: "."))
        }
        return text
    }
    
    func parseString(name property: String) throws -> String {
        let path = self.path + [property]
        guard let text = self.obj[property] as? String else {
            throw NotionSerializationError.missing(path.joined(separator: "."))
        }
        return text
    }
    
    func parseBool(name property: String) throws -> Bool {
        let path = self.path + [property]
        guard let res = self.obj[property] as? Bool else {
            throw NotionSerializationError.missing(path.joined(separator: "."))
        }
        return res
    }
    
    func parseInt(name property: String) throws -> Int {
        let path = self.path + [property]
        guard let res = self.obj[property] as? Int else {
            throw NotionSerializationError.missing(path.joined(separator: "."))
        }
        return res
    }
    
    func parseDouble(name property: String) throws -> Double {
        let path = self.path + [property]
        guard let res = self.obj[property] as? Double else {
            throw NotionSerializationError.missing(path.joined(separator: "."))
        }
        return res
    }
    
    func parseDate(name property: String, isUtc: Bool = false) throws -> Date {
        let path = self.path + [property]
        guard let text = self.obj[property] as? String else {
            throw NotionSerializationError.missing(path.joined(separator: "."))
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
        dateFormatter.timeZone = isUtc ? TimeZone.init(abbreviation: "UTC") : TimeZone.current
        dateFormatter.locale = Locale.current
        guard let date = dateFormatter.date(from:text) else {
            throw NotionSerializationError.missing(path.joined(separator: "."))
        }
        return date
    }
    
    func parseOnlyDate(name property: String) throws -> Date {
        let path = self.path + [property]
        guard let text = self.obj[property] as? String else {
            throw NotionSerializationError.missing(path.joined(separator: "."))
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        guard let date = dateFormatter.date(from:text) else {
            throw NotionSerializationError.missing(path.joined(separator: "."))
        }
        return date
    }
    
    func hasProperty(name property: String) -> Bool {
        return self.obj.keys.contains(property)
    }
    
    func isNil(name property: String) -> Bool {
        let value = self.obj[property]
        return (value as? NSNull) != nil
    }
}

