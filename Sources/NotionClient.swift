

import Foundation

@available(iOS 15.0, macOS 12.0, *)
public class NotionClient {
    
    let timeout = 20.0
    let version = "2022-02-22"    
    
    let token: String
    
    public init(token: String) {
        self.token = token
    }
    
    static func parseError(data: Any) -> NotionResponseErrorModel? {
        do {
            let root = try JsonParseObject(data)
            return root.tryParseError()
        } catch {
            return nil
        }
    }
    
    func sendRequest<T>(url: String, parser: (Any) throws -> T, body: [String: Any]? = nil, httpMethod: HttpMethod = HttpMethod.Post) async throws -> T {
        let request = try self.createRequest(url: url, httpMethod: httpMethod, body: body)
        let urlSession = URLSession.shared

        var (data, _): (Data, URLResponse), json: Any, obj: T
        
        do { (data, _) = try await urlSession.data(for: request) }
        catch { throw NotionClientError.internalClientError(description: error.localizedDescription) }
        
        do { json = try JSONSerialization.jsonObject(with: data, options: []) }
        catch { throw NotionClientError.internalClientSerializationError(description: error.localizedDescription) }
        
        if let errorResponse = NotionClient.parseError(data: json) {
            throw NotionClientError.errorResponse(description: errorResponse.description)
        }
        
        do { obj = try parser(json) }
        catch NotionSerializationError.missing(let path) { throw NotionClientError.jsonParserError(description: path) }
        catch { throw NotionClientError.jsonParserError(description: error.localizedDescription) }

        return obj
    }
    
    func createRequest(url: String, httpMethod: HttpMethod = HttpMethod.Post, body bodyNil: [String: Any]? = nil) throws -> URLRequest {
        let Url = String(format: url)
        guard let serviceUrl = URL(string: Url) else { throw NotionClientError.creatingRequestError(description: "Can not create url \(Url)") }
        var request = URLRequest(url: serviceUrl, timeoutInterval: timeout)
        request.httpMethod = httpMethod.rawValue
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(version, forHTTPHeaderField: "Notion-Version")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        if let body = bodyNil {
            do {
                let httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
                request.httpBody = httpBody
            } catch {
                throw NotionClientError.creatingRequestError(description: error.localizedDescription)
            }
            
        }
        return request
    }
}
