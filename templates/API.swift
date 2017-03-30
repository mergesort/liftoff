import Foundation

/// HTTP methods used for making URL requests as defined by [RFC-2616](https://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html).
public enum HTTPMethod: String {

    case get
    case put
    case post
    case head
    case delete
}

/// Errors that can be emitted by API requests.
public enum APIError: Error {

    /// A wrapper for around any custom `Error` type.
    case error(Error)

    /// The JSON provided to be parsed is not valid.
    case invalidJSON

    /// The JSON which was being parsed is did not match the mapping that was expected.
    case failedJSONConversion

    /// No data was receieved from the server.
    case noData

    /// A URL was not able to be created based on the parameters provided.
    case urlCreation
}

/// An endpoint to be constructed and passed to a function which can execute a network request.
public protocol Endpoint {

    /// The `baseUrl` (as defined by [RFC-3986](https://tools.ietf.org/html/rfc3986)) which the endpoint will use for constructing a request.
    var baseUrl: String { get }

    /// The `path` (as defined by [RFC-3986](https://tools.ietf.org/html/rfc3986)) which the endpoint will use for constructing a request.
    var path: String { get }

    /// The HTTP method to use when executing a request.
    var httpMethod: HTTPMethod { get }

    /// An optional `port` (as defined by [RFC-3986](https://tools.ietf.org/html/rfc3986)) to provide for URL requests. Commonly used for testing against a local environment.
    var port: Int? { get }
}

/// Encoding that can be used for the `Accept` and `Content-Type` header fields in a URL request.
public enum RequestEncoding {

    /// The JSON Accept/Content-Type encoding.
    case json

    /// The Form-URLEncoded Accept/Content-Type encoding.
    case form

    /// The JSON text/html Accept/Content-Type encoding.
    case textHTML

    func headerString() -> String {
        switch self {

        case .json:
            return "application/json; charset=utf-8; v=2"

        case .form:
            return "application/x-www-form-urlencoded; charset=utf-8; v=2"

        case .textHTML:
            return "text/html"
        }
    }
}

public enum API {

    private static let urlSession: URLSession = {
        let urlSession = URLSession(configuration: URLSessionConfiguration.teachableConfiguration)

        return urlSession
    }()

    /// This function takes in assorted parameters to construct a URLRequest, and executes that request,
    /// vending a `URLSessionDataTask`.
    ///
    /// - Parameters:
    ///   - endpoint: A type that conforms to the `Endpoint` protocol.
    ///   - parameters: URL parameters, as to pass through in a `GET`, `POST`, or `PUT` request.
    ///   - headers: Additional headers which may be passed through to a server.
    ///   - contentType: A `RequestEncoding` to describe the content type expected by the server.
    ///   - acceptEncoding: A `RequestEncoding` to describe the content type expected in response by the client.
    ///   - queue: The queue on which the `URLSessionDataTask` should be vended.
    ///   - completion: An optional completion block to be called after a response is received.
    /// - Returns: A `URLSessionDataTask` which should be executed when making a request.
    public static func executeRequest(endpoint: Endpoint, parameters: [String: Any]? = nil, headers: [String: String]? = nil, contentType: RequestEncoding = RequestEncoding.json, acceptEncoding: RequestEncoding = RequestEncoding.json, queue: DispatchQueue = DispatchQueue.main, completion: ((_ data: Data?, _ response: URLResponse?, _ error: APIError?) -> Void)? = nil) -> URLSessionDataTask {
        let emptyTask = URLSessionDataTask()

        guard var components = URLComponents(string: endpoint.baseUrl) else {
            completion?(nil, nil, APIError.urlCreation)
            return emptyTask
        }

        components.path = endpoint.path

        if let port = endpoint.port {
            components.port = port
        }

        let isGetRequest = endpoint.httpMethod == .get
        if let parameters = parameters, isGetRequest {
            components.queryItems = parameters.map { URLQueryItem(name: $0, value: $1 as? String) }
        }

        guard let url = components.url else {
            completion?(nil, nil, APIError.urlCreation)
            return emptyTask
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.httpMethod.rawValue

        if let parameters = parameters, !isGetRequest {
            let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions(rawValue: 0))
            request.httpBody = jsonData
        }

        request.addValue(acceptEncoding.headerString(), forHTTPHeaderField: "Accept")
        request.addValue(contentType.headerString(), forHTTPHeaderField: "Content-Type")

        request.httpShouldHandleCookies = false

        headers?.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }

        let task = self.urlSession.dataTask(with: request) { data, response, error in
            if let error = error {
                queue.async {
                    completion?(nil, response, APIError.error(error))
                }

                return
            }

            guard let data = data else {
                queue.async {
                    completion?(nil, response, APIError.noData)
                }
                return
            }

            queue.async {
                completion?(data, response, nil)
            }
        }

        task.resume()

        return task
    }
}

private extension URLSessionConfiguration {

    static var teachableConfiguration: URLSessionConfiguration {
        let configuration = URLSessionConfiguration.default

        return configuration
    }
}
