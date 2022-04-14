import Foundation

public enum UrlConstants {
    public static let url = "https://api.notion.com/v1"
    public static let databasesUrl = "\(url)/databases"
    public static let pagesUrl = "\(url)/pages"
    public static func createPagesUrl(id: String) -> String { "\(pagesUrl)/\(id)" }
    public static func createDatabaseQueryUrl(databaseId: String) -> String { "\(databasesUrl)/\(databaseId)/query" }
}
