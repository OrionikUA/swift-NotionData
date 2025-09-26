import Foundation

public enum UrlConstants {
    public static let url = "https://api.notion.com/v1"
    public static let databasesUrl = "\(url)/databases"
    public static let dataSourcesUrl = "\(url)/data_sources"
    public static let pagesUrl = "\(url)/pages"
    public static let blocksUrl = "\(url)/blocks"
    public static func createPagesUrl(id: String) -> String { "\(pagesUrl)/\(id)" }
    public static func createDatabaseQueryUrl(databaseId: String) -> String { "\(databasesUrl)/\(databaseId)/query" }
    public static func createDataSourcesQueryUrl(dataSourceId: String) -> String { "\(dataSourcesUrl)/\(dataSourceId)/query" }
    public static func createBlocksIdUrl(id: String) -> String { "\(blocksUrl)/\(id)" }
    public static func createBlocksChildrenIdUrl(id: String) -> String { "\(createBlocksIdUrl(id: id))/children" }
}
