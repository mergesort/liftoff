import Foundation

public enum APIError: Error {

    case error(Error)
    case jsonParsingError
    case jsonConversionError
    case jsonDeserializationError
    case noDataError
    case urlCreationError
}

public protocol Path {

    var baseUrl: String { get }
    var path: String { get }
}

public protocol Endpoint: Path {

    var baseUrl: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var port: Int? { get }
}

public enum RequestEncoding {

    case json
    case form
    case textHTML

    public func headerString() -> String {
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

public enum HTTPMethod: String {

    case get
    case put
    case post
    case delete
}

public enum API {

    public static func executeRequest(endpoint: Endpoint, parameters: [String: Any]? = nil, headers: [String: String]? = nil, contentType: RequestEncoding = RequestEncoding.json, acceptEncoding: RequestEncoding = RequestEncoding.json, queue: DispatchQueue = DispatchQueue.main, completion: ((_ data: Data?, _ error: APIError?) -> Void)? = nil) -> URLSessionDataTask {
        let emptyTask = URLSessionDataTask()

        if var components = URLComponents(string: endpoint.baseUrl) {
            components.path = endpoint.path

            if let port = endpoint.port {
                components.port = port
            }

            let isGetRequest = endpoint.httpMethod == .get
            if let parameters = parameters, isGetRequest {
                components.queryItems = parameters.map { URLQueryItem(name: $0, value: $1 as? String) }
            }

            guard let url = components.url else {
                completion?(nil, APIError.urlCreationError)
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

            headers?.forEach { key, value in
                request.addValue(value, forHTTPHeaderField: key)
            }

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    queue.async {
                        completion?(nil, APIError.error(error))
                    }

                    return
                }

                guard let data = data else {
                    queue.async {
                        completion?(nil, APIError.noDataError)
                    }
                    return
                }

                queue.async {
                    completion?(data, nil)
                }
            }

            task.resume()

            return task
        } else {
            completion?(nil, APIError.urlCreationError)
            return emptyTask
        }
    }
}
