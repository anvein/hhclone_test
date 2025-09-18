import Foundation

protocol ApiRoute {
    var path: [String] { get }
    var queryParams: [URLQueryItem] { get }
    var method: ApiHttpMethod { get }
    var headers: [String: String] { get }

}

extension ApiRoute {
    var queryParams: [URLQueryItem] { [] }
    var method: ApiHttpMethod { .get }
    var headers: [String: String] { [:] }

    var pathString: String {
        path.joined(separator: "/")
    }
}

