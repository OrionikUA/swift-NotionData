
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
}
